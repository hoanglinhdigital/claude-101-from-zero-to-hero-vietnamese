---
name: add-feature
description: Quy trình chuẩn để thêm một tính năng mới vào dự án lab-realestate theo đúng kiến trúc 3 tầng, phân quyền và test. Dùng khi được yêu cầu thêm tính năng, trang, hoặc nghiệp vụ mới.
---

# Thêm tính năng mới — quy trình chuẩn

Thực hiện lần lượt, không bỏ bước:

1. **Đọc luật chơi**: đọc `docs/DOMAIN.md` (ma trận quyền, luồng trạng thái) và `docs/ARCHITECTURE.md`. Xác định role nào được làm gì với tính năng này.
2. **Lập kế hoạch ngắn** (5–8 dòng): file sẽ tạo/sửa theo từng tầng. Nếu cần đổi schema Prisma, dừng lại và hỏi người dùng.
3. **Validator**: tạo Zod schema trong `src/lib/validators/<domain>.ts`.
4. **Service**: thêm hàm vào `src/services/<domain>-service.ts`; tham số đầu là `actor`; gọi `requireRole`/`requireUser` trước khi đọc/ghi; throw `AppError` cho lỗi nghiệp vụ.
5. **Test trước khi làm UI**: viết unit test cho service, bắt buộc có ca "role không được phép bị từ chối" và ca "dữ liệu không hợp lệ".
6. **Server action** mỏng (validate -> session -> service -> revalidate/redirect) rồi mới tới **UI**.
7. **Kiểm chứng**: chạy `npm run typecheck`, `npm run lint`, `npm run check:arch`, `npm test`. Sửa đến khi pass.
8. **Review**: gọi sub-agent `code-reviewer` trên thay đổi vừa làm, sửa các vấn đề mức CAO/TRUNG BÌNH.
9. **Báo cáo**: liệt kê file đã đổi, kết quả 4 lệnh, và các điểm cần người dùng quyết định.
