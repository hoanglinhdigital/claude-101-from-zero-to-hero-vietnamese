# find-and-replace.py — Hướng dẫn sử dụng

Script Python tìm và thay thế văn bản trong tất cả file `.html` (đệ quy thư mục con) bên trong một thư mục chỉ định.

---

## Yêu cầu

- Python 3.10+
- Không cần cài thêm thư viện ngoài (dùng stdlib thuần)
- Chạy từ **thư mục gốc của project**

---

## Cú pháp

```bash
python tools/find-and-replace.py <thư-mục> "<text-cần-tìm>" "<text-thay-thế>"
```

**Ví dụ:**

```bash
# Đổi tên class trong toàn bộ chương của section 2
python tools/find-and-replace.py section/section_2 "old-class-name" "new-class-name"

# Sửa đường dẫn stylesheet cũ thành mới
python tools/find-and-replace.py section "href=\"../styles.css\"" "href=\"../../styles.css\""

# Xoá một đoạn HTML lỗi (thay bằng chuỗi rỗng)
python tools/find-and-replace.py section/section_3 "<span class=\"deprecated\">" ""

# Sửa tên miền trong tất cả file HTML của project
python tools/find-and-replace.py . "oldsite.example.com" "newsite.example.com"
```

---

## Script làm gì

1. **Quét đệ quy** tất cả file `.html` trong thư mục được chỉ định.
2. **Kiểm tra** từng file — nếu chứa `text-cần-tìm` thì thực hiện thay thế.
3. **Thay thế** toàn bộ lần xuất hiện của `text-cần-tìm` bằng `text-thay-thế`.
4. **Ghi đè** file gốc — chỉ những file thực sự có thay đổi mới bị ghi đè.
5. **In báo cáo** ra terminal: danh sách file bị sửa, số lần thay thế mỗi file.

---

## Output mẫu

```
Folder      : section\section_2
Find        : old-class-name
Replace     : new-class-name
Scanning    : 8 .html file(s)

  [  5 replacement(s)]  chapter_1.html
  [ 12 replacement(s)]  chapter_3.html
  [  1 replacement(s)]  chapter_5.html

Modified 3 file(s), 18 total replacement(s).
Done.
```

---

## Lưu ý quan trọng

| Tình huống | Hành vi |
|---|---|
| File không chứa `text-cần-tìm` | Bỏ qua, không ghi đè |
| `text-cần-tìm` xuất hiện nhiều lần | Thay thế tất cả lần xuất hiện |
| `text-thay-thế` là chuỗi rỗng | Xoá toàn bộ lần xuất hiện của `text-cần-tìm` |
| Thư mục không có file `.html` | Báo "No .html files found" và thoát |
| `text-cần-tìm` rỗng | Báo lỗi và thoát |

---

## Giới hạn

- **Không hỗ trợ regex** — tìm kiếm chính xác chuỗi ký tự (case-sensitive).
- **Không có dry-run** — thay đổi được ghi trực tiếp vào file. Nên dùng Git để có thể rollback nếu cần.
- **Chỉ xử lý file `.html`** — không ảnh hưởng đến `.css`, `.js`, `.md`, hay file khác.

---

## Quy trình khuyến nghị

```bash
# Bước 1: Đảm bảo code sạch (có thể rollback)
git status
git diff

# Bước 2: Chạy script
python tools/find-and-replace.py section/section_2 "old-text" "new-text"

# Bước 3: Kiểm tra kết quả
git diff

# Bước 4: Nếu OK thì commit; nếu lỗi thì reset
git add section/ && git commit -m "Replace old-text with new-text in section 2"
# hoặc: git checkout -- section/   (rollback nếu cần)
```

---

## Chạy hàng loạt nhiều lần thay thế

```bash
# PowerShell — thay thế nhiều pattern liên tiếp
$replacements = @(
    @("old-class-1", "new-class-1"),
    @("old-class-2", "new-class-2"),
    @("old-class-3", "new-class-3")
)
foreach ($pair in $replacements) {
    python tools/find-and-replace.py section/ $pair[0] $pair[1]
}

# Bash / Git Bash — tương tự
for pair in "old-class-1:new-class-1" "old-class-2:new-class-2"; do
  OLD="${pair%:*}"
  NEW="${pair#*:}"
  python tools/find-and-replace.py section/ "$OLD" "$NEW"
done
```
