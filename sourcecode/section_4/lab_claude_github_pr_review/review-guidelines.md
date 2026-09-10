# Review Guidelines — Expense Management

Tài liệu này được Claude đọc trong mỗi lần review pull request.
Đặt file tại `.github/review-guidelines.md` trong repository.

## 1. Bảo mật dữ liệu người dùng (mức độ: Nghiêm trọng)

- Mọi truy vấn Prisma đọc/ghi dữ liệu nghiệp vụ BẮT BUỘC có điều kiện
  `userId` của người đang đăng nhập.
- Không nhận `userId` từ query param hoặc request body của client.
- Không trả về `passwordHash` hoặc bất kỳ field nhạy cảm nào trong response.

## 2. Kiểu dữ liệu tiền tệ (mức độ: Nghiêm trọng)

- `amount`, `balance`, `initialBalance`, `budget`: `Decimal @db.Decimal(18, 2)`.
- Cấm `Float`, `Double`, và cấm cộng/trừ tiền bằng `Number` trong JavaScript.
- Số tiền trả về API dưới dạng chuỗi decimal (`.toString()`).

## 3. Soft delete (mức độ: Nghiêm trọng)

- Không hard delete. Xoá = `isDeleted: true`.
- Mọi truy vấn đọc phải có `isDeleted: false`.

## 4. Validation (mức độ: Cảnh báo)

- Query param và request body phải validate bằng zod trước khi dùng.
- Sai định dạng trả 400 kèm thông báo cụ thể, không để lộ lỗi gốc của Prisma.

## 5. Hiệu năng (mức độ: Cảnh báo)

- Cấm truy vấn trong vòng lặp (N+1). Dùng `include`, `groupBy` hoặc `aggregate`.
- Tính tổng/thống kê để database làm, không load hết bản ghi rồi cộng bằng JavaScript.
- Mọi field dùng để lọc hoặc sắp xếp phải có index.

## 6. Những gì KHÔNG cần báo cáo

- Format code, thứ tự import, khoảng trắng (đã có Prettier/ESLint lo).
- Sở thích đặt tên biến nếu vẫn đúng convention của project.
- Đề xuất refactor không liên quan đến phạm vi thay đổi của pull request.
