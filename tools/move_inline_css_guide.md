# move_inline_css.py — Hướng dẫn sử dụng

Script Python tự động di chuyển toàn bộ CSS nằm trong thẻ `<style>…</style>` của một file HTML sang file `styles.css` toàn cục.

---

## Yêu cầu

- Python 3.10+
- Không cần cài thêm thư viện ngoài (dùng stdlib thuần)
- Chạy từ **thư mục gốc của project** (nơi chứa `styles.css`)

---

## Cú pháp

```bash
python tools/move_inline_css.py <đường-dẫn-tương-đối-đến-file.html>
```

**Ví dụ:**

```bash
python tools/move_inline_css.py section/section_2/chapter_1.html
```

---

## Script làm gì

1. **Đọc** toàn bộ thẻ `<style>…</style>` trong file HTML được chỉ định.
2. **Parse** các CSS rule (selector + properties) từ các block đó.
3. **Merge vào `styles.css`:**
   - Selector **đã tồn tại** trong `styles.css` → merge properties vào block hiện có (property từ HTML ghi đè nếu trùng tên).
   - Selector **chưa có** trong `styles.css` → append xuống cuối file với comment `/* Moved from inline <style> */`.
4. **Xoá** toàn bộ thẻ `<style>…</style>` khỏi file HTML.
5. In báo cáo ra terminal: mỗi selector được `[updated]` hay `[appended]`, tổng số rule đã xử lý.

---

## Output mẫu

```
Input : section\section_2\chapter_4.html
Target: D:\Project Code\advanced-aws-curriculum\styles.css

Found 1 <style> block(s) with 46 CSS rule(s).

  [updated]  .section-heading
  [updated]  .card
  [appended] .arch-diagram
  [appended] .arch-row
  ...

styles.css: 34 rule(s) updated, 12 rule(s) appended.
HTML file : <style> block(s) removed from section\section_2\chapter_4.html

Done.
```

---

## Lưu ý quan trọng

| Tình huống | Hành vi |
|---|---|
| Selector trùng tên, property trùng tên | Property từ HTML **ghi đè** property trong `styles.css` |
| Selector trùng tên, property mới | Property mới được **thêm** vào block hiện có |
| Selector chưa có trong `styles.css` | Selector được **append** cuối file |
| `@media`, `@keyframes` và các at-rule lồng nhau | **Bỏ qua** — không di chuyển, không xoá |
| Comment `/* … */` trong `<style>` | Bị loại bỏ khi parse (không copy sang `styles.css`) |
| Nhiều thẻ `<style>` trong một file HTML | Xử lý **tất cả**, xoá hết sau khi di chuyển |
| File HTML không có thẻ `<style>` | Báo "nothing to do", không thay đổi file nào |

---

## Giới hạn

- Không hỗ trợ CSS lồng nhau (`@media { .class { … } }`) — các rule này bị bỏ qua thay vì di chuyển.
- Không giữ lại comment gốc từ `<style>` block.
- Không tự động thêm `<link rel="stylesheet" href="../../styles.css" />` vào HTML nếu chưa có — kiểm tra thủ công.

---

## Quy trình khuyến nghị khi dùng hàng loạt

```bash
# Chạy từ thư mục gốc project
cd "D:/Project Code/advanced-aws-curriculum"

# Xử lý lần lượt từng file
python tools/move_inline_css.py section/section_2/chapter_1.html
python tools/move_inline_css.py section/section_2/chapter_4.html
python tools/move_inline_css.py section/section_3/chapter_2.html

# Hoặc dùng PowerShell để chạy tất cả file trong một section
Get-ChildItem section/section_2/*.html | ForEach-Object {
    python tools/move_inline_css.py $_.FullName.Replace("$PWD\", "")
}
```

---

## Kiểm tra sau khi chạy

```bash
# Xác nhận không còn <style> block nào trong file đã xử lý
Select-String -Path section/section_2/chapter_1.html -Pattern "<style"

# Xem các class vừa được append vào cuối styles.css
Select-String -Path styles.css -Pattern "Moved from inline"
```
