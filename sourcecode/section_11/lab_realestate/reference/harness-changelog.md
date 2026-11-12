# Harness changelog — lab-realestate

Mỗi dòng = một lỗi lặp lại đã được biến thành cải tiến harness. Chỉ thêm khi có bằng chứng (transcript/scoreboard), không thêm theo cảm tính.

| Ngày | Lỗi quan sát được | Nguyên nhân gốc | Loại cải tiến | Thay đổi | Kết quả đo lại |
|---|---|---|---|---|---|
| (ví dụ) | Task T3: hàm lấy tin của một tài khoản không kiểm tra role ở tầng service | docs/DOMAIN.md chưa nêu quy tắc cho hàm đọc dữ liệu quản trị | Guide | Thêm mục "Hàm đọc dữ liệu không công khai" vào docs/DOMAIN.md | v1: 2/3 -> v2: 3/3 |
| (điền) | (điền) | (điền) | Guide / Sensor | (điền) | (điền) |

## Quy tắc ghi changelog
1. Mô tả lỗi bằng dữ kiện (tên task, thông báo lỗi), không dùng "model hay quên".
2. Ưu tiên sensor (kiểm tra bằng code) hơn guide (nhắc bằng chữ) nếu lỗi có thể kiểm tra tự động.
3. Mỗi thay đổi phải có số liệu đo lại bằng `run-eval.ps1`.
4. Định kỳ rà soát: rule nào model mới đã làm đúng mà không cần nhắc thì xoá để harness gọn.
