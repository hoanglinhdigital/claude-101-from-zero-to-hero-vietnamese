
## Session protocol (tác vụ nhiều phiên)
Bắt đầu phiên:
1. Đọc phần "TRẠNG THÁI DỰ ÁN" do hook nạp sẵn; nếu thiếu, đọc `progress.md` và `git log -5`.
2. Chạy `powershell -NoProfile -ExecutionPolicy Bypass -File init.ps1`. Nếu FAIL, sửa lỗi nền trước.
3. Chọn đúng MỘT feature có `passes: false` đầu tiên trong `feature_list.json`.

Trong phiên:
4. Chỉ làm feature đã chọn, theo skill `add-feature`. Không làm "tiện thể" feature khác.
5. Tự kiểm chứng theo từng dòng trong `steps` của feature trước khi kết luận.

Kết thúc phiên:
6. Chỉ đổi `passes` thành `true` khi mọi `steps` đã được kiểm chứng. Cấm sửa/xoá `description`, `steps`.
7. Thêm một mục vào cuối `progress.md`: đã làm gì, trạng thái, việc tiếp theo, vấn đề còn tồn đọng.
8. `git add` + `git commit` với message dạng `feat(F00X): ...`. Dự án phải ở trạng thái build được.
