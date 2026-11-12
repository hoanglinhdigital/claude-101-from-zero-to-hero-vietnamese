# Kiến trúc — lab-realestate

## Các tầng
```
src/app, src/components   UI: render + server actions mỏng
        |
        v
src/services              Nghiệp vụ + phân quyền + truy cập DB (Prisma)
        |
        v
src/lib/prisma.ts         PrismaClient singleton
```
Thư mục dùng chung: `src/lib/authz.ts`, `src/lib/session.ts`, `src/lib/errors.ts`, `src/lib/validators/*`.

## Quy tắc
1. UI không import `@prisma/client` (cho phép `import type`) và không import `@/lib/prisma`. UI chỉ gọi hàm trong `src/services`.
2. Truy vấn Prisma chỉ nằm trong `src/services/*-service.ts`.
3. Mỗi hàm service nhận `actor: SessionUser | null` làm tham số đầu tiên và gọi `requireRole(actor, [...])` hoặc `requireUser(actor)` trước khi đọc/ghi dữ liệu không công khai.
4. Server action (`src/app/**/actions.ts`) chỉ làm 4 việc: validate bằng Zod -> lấy session (`getSessionUser`) -> gọi service -> `revalidatePath`/`redirect`.
5. Lỗi nghiệp vụ throw `AppError` (`src/lib/errors.ts`) với mã: `UNAUTHENTICATED`, `FORBIDDEN`, `NOT_FOUND`, `VALIDATION`.
6. Đặt tên: file kebab-case; service là `<domain>-service.ts` (ví dụ `listing-service.ts`).
7. Test: `src/services/__tests__/<domain>-service.test.ts` (Vitest, mock `@/lib/prisma`).
8. Service không import từ `src/app`, `src/components` hoặc `next/*`.

## Ví dụ đúng
```ts
// src/app/listings/page.tsx
import { listApprovedListings } from '@/services/listing-service';

export default async function ListingsPage() {
  const listings = await listApprovedListings(null, {});
  return <ul>{listings.map((l) => <li key={l.id}>{l.title}</li>)}</ul>;
}
```

## Ví dụ sai (bị `npm run check:arch` chặn)
```ts
// src/app/listings/page.tsx
import { prisma } from '@/lib/prisma'; // SAI: UI gọi thẳng DB
```

## Khi vi phạm
Chuyển truy vấn vào hàm service tương ứng rồi gọi từ UI.
