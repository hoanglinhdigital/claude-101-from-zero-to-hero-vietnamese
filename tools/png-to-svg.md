========================================================
  HƯỚNG DẪN SỬ DỤNG: png-to-svg.py
  Chuyển đổi ảnh PNG sang định dạng SVG
========================================================

--------------------------------------------------------
1. YÊU CẦU HỆ THỐNG
--------------------------------------------------------

- Python 3.9 trở lên
- (Tuỳ chọn) Pillow  — đọc kích thước ảnh chính xác hơn
- (Tuỳ chọn) vtracer — bắt buộc nếu dùng chế độ --trace

Cài đặt thư viện tuỳ chọn:
  pip install pillow
  pip install vtracer


--------------------------------------------------------
2. HAI CHẾ ĐỘ HOẠT ĐỘNG
--------------------------------------------------------

[EMBED — Mặc định]
  Nhúng toàn bộ dữ liệu PNG dưới dạng base64 vào bên
  trong thẻ <image> của SVG. File SVG sinh ra vẫn chứa
  ảnh raster bên trong.

  Ưu điểm:
    + Không cần cài thêm thư viện nào
    + Giữ nguyên 100% màu sắc và chi tiết gốc
    + Xử lý nhanh, phù hợp mọi loại ảnh

  Nhược điểm:
    - Không phóng to vô hạn mà vẫn sắc nét (vẫn là raster)
    - File SVG có kích thước tương đương PNG gốc

[TRACE — Vectorize thật sự]
  Phân tích màu sắc và chuyển ảnh thành các đường path
  vector thật sự bằng thư viện vtracer.

  Ưu điểm:
    + SVG thật sự — phóng to vô hạn vẫn sắc nét
    + File nhỏ hơn nhiều với ảnh đơn giản (logo, icon)

  Nhược điểm:
    - Cần cài vtracer (pip install vtracer)
    - Ảnh phức tạp (ảnh chụp, gradient mịn) cho kết quả
      kém chính xác hơn ảnh gốc
    - Xử lý chậm hơn embed


--------------------------------------------------------
3. CÁCH SỬ DỤNG
--------------------------------------------------------

Cú pháp cơ bản:
  python tools/png-to-svg.py <input.png> [tuỳ chọn]

--- Ví dụ ---

# Chuyển đổi một file, output cùng thư mục với input
  python tools/png-to-svg.py aws-svg/data-center.png

# Chỉ định file output
  python tools/png-to-svg.py aws-svg/data-center.png -o aws-svg/data-center.svg

# Dùng chế độ vectorize (trace)
  python tools/png-to-svg.py aws-svg/data-center.png --trace

# Batch nhiều file cùng lúc (chế độ embed)
  python tools/png-to-svg.py aws-svg/*.png

# Batch nhiều file cùng lúc (chế độ trace)
  python tools/png-to-svg.py aws-svg/*.png --trace


--------------------------------------------------------
4. CÁC THAM SỐ ĐẦY ĐỦ
--------------------------------------------------------

  inputs          File PNG đầu vào (có thể truyền nhiều file)
  -o, --output    Chỉ định file SVG đầu ra (chỉ dùng với 1 input)
  --embed         Chế độ nhúng base64 (mặc định, không cần khai báo)
  --trace         Chế độ vectorize thật sự bằng vtracer


--------------------------------------------------------
5. KHUYẾN NGHỊ SỬ DỤNG
--------------------------------------------------------

Loại ảnh                     | Chế độ khuyên dùng
-----------------------------|--------------------
AWS icon, logo phẳng         | --trace
Icon ít màu, hình đơn giản   | --trace
Ảnh chụp, hình ảnh thực      | --embed (mặc định)
Ảnh có gradient phức tạp     | --embed (mặc định)
Cần xử lý nhanh, batch lớn  | --embed (mặc định)
Dùng trong Mermaid diagram   | --trace (SVG thuần)


--------------------------------------------------------
6. VÍ DỤ WORKFLOW CHO DỰ ÁN NÀY
--------------------------------------------------------

Bước 1: Tải AWS icon dạng PNG về thư mục aws-svg/
Bước 2: Chuyển đổi sang SVG bằng lệnh:

  python tools/png-to-svg.py aws-svg/data-center.png --trace

Bước 3: Dùng SVG trong Mermaid diagram:

  flowchart LR
    DC["<img src='../../aws-svg/data-center.svg'
         style='width:40px;height:40px;'/><br/>Data Center"]


--------------------------------------------------------
7. TROUBLESHOOT
--------------------------------------------------------

Lỗi: "vtracer is not installed"
  -> Chạy: pip install vtracer
  -> Hoặc bỏ --trace để dùng chế độ embed (không cần vtracer)

Lỗi: "File not found"
  -> Kiểm tra đường dẫn file PNG, dùng dấu nháy kép nếu
     tên file có khoảng trắng:
     python tools/png-to-svg.py "aws-svg/my icon.png"

Lỗi: "not a valid PNG file"
  -> File có thể bị hỏng hoặc không phải định dạng PNG thật.
     Thử mở lại bằng trình xem ảnh để kiểm tra.

Kết quả --trace trông méo / sai màu
  -> Ảnh quá phức tạp cho vectorize. Dùng --embed thay thế.

========================================================
