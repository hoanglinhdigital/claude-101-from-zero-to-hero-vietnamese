// scripts/check-architecture.mjs
// Sensor "computational": kiểm tra ranh giới tầng bằng code, không dùng LLM.
// Chạy: node scripts/check-architecture.mjs  (exit 0 = đạt, exit 1 = vi phạm)
import { readdirSync, readFileSync, statSync, existsSync } from 'node:fs';
import { join, extname } from 'node:path';

const PRISMA_RUNTIME = [
  /^\s*import\s+(?!type\b).*from\s+['"]@prisma\/client['"]/,
  /^\s*import\s+(?!type\b).*from\s+['"]@\/lib\/(prisma|db)['"]/,
  /^\s*import\s+(?!type\b).*from\s+['"](\.{1,2}\/)+.*lib\/(prisma|db)['"]/,
  /require\(\s*['"]@prisma\/client['"]\s*\)/,
];

const RULES = [
  {
    name: 'UI không được gọi thẳng DB',
    dirs: ['src/app', 'src/components'],
    forbidden: PRISMA_RUNTIME,
    fix: 'Chuyển truy vấn sang src/services/*-service.ts rồi gọi hàm service từ UI (xem docs/ARCHITECTURE.md).',
  },
  {
    name: 'Service không được import từ UI hoặc next/*',
    dirs: ['src/services'],
    forbidden: [/from\s+['"]@\/(app|components)\//, /from\s+['"]next\//],
    fix: 'Service chỉ nhận/trả dữ liệu thuần; việc redirect/revalidate thuộc server action.',
  },
];

const EXTENSIONS = new Set(['.ts', '.tsx', '.js', '.jsx']);

function walk(dir) {
  if (!existsSync(dir)) return [];
  return readdirSync(dir).flatMap((name) => {
    const full = join(dir, name);
    if (statSync(full).isDirectory()) return walk(full);
    return EXTENSIONS.has(extname(full)) ? [full] : [];
  });
}

const violations = [];
for (const rule of RULES) {
  for (const dir of rule.dirs) {
    for (const file of walk(dir)) {
      if (/\.test\.(ts|tsx)$/.test(file)) continue;
      readFileSync(file, 'utf8')
        .split(/\r?\n/)
        .forEach((line, i) => {
          if (rule.forbidden.some((re) => re.test(line))) {
            violations.push(`${file}:${i + 1}  [${rule.name}]  ${line.trim()}\n    -> Cách sửa: ${rule.fix}`);
          }
        });
    }
  }
}

if (violations.length > 0) {
  console.error('VI PHẠM KIẾN TRÚC:\n' + violations.join('\n'));
  process.exit(1);
}
console.log('Kiểm tra kiến trúc: OK');
