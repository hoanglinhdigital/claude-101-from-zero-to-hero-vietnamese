# CLAUDE.md — lab-realestate

Website bất động sản: Next.js (App Router, TypeScript) + Prisma + PostgreSQL (docker-compose).
File này là **bản đồ ngắn**. Chi tiết nằm trong `docs/` — đọc khi cần.

## Lệnh quan trọng
- Chạy DB: `docker compose up -d db`
- Dev server: `npm run dev`
- Typecheck: `npm run typecheck` · Lint: `npm run lint` · Test: `npm test`
- Kiểm tra kiến trúc: `npm run check:arch`
- Prisma: `npx prisma migrate dev` · `npx prisma db seed`

## Quy tắc bắt buộc
1. Kiến trúc 3 tầng: UI (`src/app`, `src/components`) -> `src/services` -> `src/lib/prisma.ts`.
   UI **không** import `@prisma/client` (trừ `import type`) hay `@/lib/prisma`. Chi tiết: `docs/ARCHITECTURE.md`.
2. Phân quyền luôn kiểm tra ở tầng service bằng `requireRole`/`requireUser` (`src/lib/authz.ts`). Ma trận quyền: `docs/DOMAIN.md`.
3. Input từ form/API phải validate bằng Zod (`src/lib/validators`).
4. Mỗi hàm service mới phải có unit test trong `src/services/__tests__`.
5. Không sửa `prisma/schema.prisma` hoặc chạy migration khi chưa được yêu cầu rõ ràng.
6. Không dùng `any`; không tắt rule ESLint bằng comment; không đọc/in nội dung `.env`.

## Definition of Done
Chỉ báo "xong" khi `npm run typecheck`, `npm run lint`, `npm run check:arch`, `npm test` đều pass.
Báo cáo kết quả từng lệnh.

## Tài liệu tham chiếu
- `docs/ARCHITECTURE.md` — các tầng, quy ước code, ví dụ đúng/sai.
- `docs/DOMAIN.md` — 4 role, ma trận phân quyền, luồng trạng thái tin đăng.
