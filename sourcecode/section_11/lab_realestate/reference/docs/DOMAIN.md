# Nghiệp vụ — lab-realestate

## 4 role
- `BUYER` (người mua): đăng tin **cần mua** (`type = WANTED`).
- `SELLER` (người bán): đăng tin **bán** (`type = SALE`).
- `MODERATOR` (quản trị viên): duyệt/từ chối tin đăng.
- `SYSTEM_ADMIN`: quản lý tài khoản và cấu hình hệ thống.
Khách (chưa đăng nhập) chỉ xem tin đã duyệt.

## Ma trận phân quyền
| Hành động | Khách | BUYER | SELLER | MODERATOR | SYSTEM_ADMIN |
|---|---|---|---|---|---|
| Xem tin `APPROVED` | có | có | có | có | có |
| Đăng tin `WANTED` | không | có | không | không | không |
| Đăng tin `SALE` | không | không | có | không | không |
| Sửa/xoá tin của chính mình | không | có | có | không | không |
| Xem tin `PENDING`/`REJECTED` của người khác | không | không | không | có | có |
| Duyệt / từ chối tin | không | không | không | có | không |
| Khoá/mở khoá tài khoản, đổi role | không | không | không | không | có |
| Xem/sửa cấu hình hệ thống | không | không | không | không | có |

## Luồng trạng thái tin đăng
- Tạo mới -> `PENDING`.
- Moderator: `PENDING` -> `APPROVED`, hoặc `PENDING` -> `REJECTED` (bắt buộc có `rejectReason`).
- Chủ tin sửa tin đã `APPROVED`/`REJECTED` -> quay về `PENDING`.
- Chủ tin có thể xoá tin ở mọi trạng thái.
- Chỉ moderator được đổi sang `APPROVED`/`REJECTED`; không ai được tự duyệt tin của mình.

## Ràng buộc khác
- Tài khoản `isActive = false` không đăng nhập được.
- Không được hạ role hoặc khoá tài khoản `SYSTEM_ADMIN` cuối cùng; không được tự khoá chính mình.
- Giá tính bằng triệu đồng (`priceMillion`, số nguyên dương); diện tích `areaM2` là số nguyên dương.
