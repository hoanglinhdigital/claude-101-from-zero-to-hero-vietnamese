# CLAUDE.md — AWS Advanced Topics Course Repository

## Giới thiệu repository

Đây là repository chứa toàn bộ tài liệu giảng dạy cho khoá học **"Claude-101 from Zero to Hero - Tiếng Việt"** 
Outline của khóa học: `outline.md`. Sử dụng để tham chiếu sự liên quan của các chương, mục tiêu thiết kế nội dung giảng dạy có tính liên kết và độ khó tăng dần.
### Cấu trúc thư mục

```
index.html                  # Shell chính: header + sidebar + iframe
styles.css                  # Global stylesheet
mermaid-config.js           # Global Style for Mermaid chart, diagrams.
welcome.html                # Trang chào mừng mặc định
generate-chapters.js        # Script tạo chapter file (Node.js)
sections/
  section_1/
    chapter_1.html          # Nội dung từng chương
    chapter_2.html
    ...
  section_N/ ...
sourcecode/                 # Source code cho các bài lab
  section_N/
    lab_<tên>/
      main.tf / commands.sh / ...
```

### Cách navigation hoạt động

- Sidebar bên trái được định nghĩa tĩnh trong `index.html`.
- Chapter file tham chiếu stylesheet qua đường dẫn tương đối `../../styles.css`.

---

## Đối tượng học viên

  - Tất cả mọi người muốn tìm hiểu về Claude. Không yêu cầu kiến thức đầu vào.
  - Muốn áp dụng Claude trong công việc hằng ngày, đặc biệt là IT (Developer, Tester, DevOps Engineer)
---

## Quy tắc tạo nội dung chương học

### Yêu cầu kỹ thuật bắt buộc

- File chapter là **HTML/CSS/JS thuần (Vanilla JS)** — không dùng thư viện ngoài (không React, Vue, Bootstrap, Tailwind...).
- Ưu tiên sử dụng global style: styles.css, mermaid-config.js  để đảm bảo tính nhất quán, dễ thay đổi phong cách sau này.
- Không thêm sidebar hay header vào chapter file — layout do `index.html` quản lý qua iframe.

---

### A. Nội dung giới thiệu các khái niệm của Claude

Cấu trúc bắt buộc theo đúng thứ tự:

1. **Giới thiệu** — 2–4 câu: Thành phần, khái niệm, dịch vụ này là gì, giải quyết vấn đề gì.
2. **Các tính năng chính** — danh sách gạch đầu dòng (`<ul>`).
3. **Mô hình kiến trúc (nếu có)** - Cách Service/Component kết nối với các dịch vụ khác như 3rd service, database, MCP Server, Internet, Github repository, Máy local, Server,... Sử dụng Mermaid Diagram.
  Bắt buộc sử dụng Mermaid Flow chart, Architecture diagram đê mô tả cách các component kết nối và giao tiếp với nhau. KHÔNG sử dụng HTML cho diagram.
  Sử dụng các Icon trong thư mục: `assets\svg-icon` cho cả các section minh hoạ và Icon của Participant trong Mermaid diagram.
  Nếu không tìm thấy Icon tương ứng phù hợp, sử dụng Emoji để thay thế.
  Tham khảo Flowchart có sử dụng AWS icons: `mermaid\sample-flowchart.mermaid`
4. **Use Cases** — ứng dụng thực tế trong các bài toán thực tế, 2-3 gạch đầu dòng.
5. **Thông tin bổ sung** — giới hạn kỹ thuật, lưu ý khi sử dụng, cách tiết kiệm chi phí.
---

### B. Nội dung bài Lab thực hành

Cấu trúc bắt buộc theo đúng thứ tự:

1. **Mục tiêu** — liệt kê những gì học viên sẽ thực hiện và đạt được.
2. **Mô hình kiến trúc (nếu có)** - Cách Service/Component kết nối với các dịch vụ khác như 3rd service, database, MCP Server, Internet, Github repository, Máy local, Server,... Sử dụng Mermaid Diagram.
  Bắt buộc sử dụng Mermaid Flow chart, Architecture diagram đê mô tả cách các component kết nối và giao tiếp với nhau. KHÔNG sử dụng HTML cho diagram.
  Sử dụng các Icon trong thư mục: `assets\svg-icon` cho cả các section minh hoạ và Icon của Participant trong Mermaid diagram.
  Nếu không tìm thấy Icon tương ứng phù hợp, sử dụng Emoji để thay thế.
  Tham khảo Flowchart có sử dụng AWS icons: `mermaid\sample-flowchart.mermaid`

3. **Yêu cầu trước khi bắt đầu** — Các tool cần cài đặt tại máy local, Anthropic account, API Key.
4. **Các bước thực hành** — chi tiết từng bước, ưu tiên dùng command. Command phải copy-paste được, không rút gọn.
5. **Troubleshoot** — các lỗi thường gặp và cách xử lý (nếu có).
6. **Dọn dẹp resource** — hướng dẫn xóa toàn bộ resource đã tạo. *Chỉ áp dụng cho các bài lab có tạo ra resource trên Cloud (ví dụ AWS).

**Format nội dung:** Command nhúng trực tiếp vào HTML. Dùng `<pre class="code-block">` cho command, `<div class="mermaid">` cho diagram.

**Source code lab** (Terraform, script) lưu tại:
```
/sourcecode/section_<N>/lab_<tên_lab>/
```
Ví dụ: `/sourcecode/section_1/lab_claude_code_basic/command.bat`

---

## Phong cách thiết kế (Design System)

**Phong cách:** Tươi sáng, light. Nền trắng là chủ đạo. Không dùng nền tối trừ header của trang shell và code block.

### Font

```css
font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
```

### Bảng màu

| Vai trò | Màu | Hex |
|---|---|---|
| Background chính | Trắng | #ffffff |
| Background trang | Xám nhạt | #f8fafc |
| Accent chính | Cam | #f97316 |
| Accent phụ | Tím | #7c3aed |
| Highlight / CTA | Cam | #c31be9 |
| Text chính | Xanh đen | #1e293b |
| Text muted | Xám | #64748b |
| Border | Xám nhạt | #e2e8f0 |
| Success | Xanh lá | #16a34a |
| Warning | Vàng | #d97706 |
| Danger | Đỏ | #ea3e0fe3 |

### CSS Components chuẩn (dùng styles.css, update khi cần thiết, reference trong cả chapter file và index.html)


---

## Template mẫu — Dịch vụ AWS

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>TÊN CHƯƠNG Claude 101</title>
  <link rel="stylesheet" href="../../styles.css" />
  <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <script src="../../mermaid-config.js"></script>
  <link rel="stylesheet" href="../../prism.css" />
  <script src="../../prism.js"></script>

</head>
<body class="chapter-body">

  <div class="chapter-breadcrumb">
    <span class="section-part">N. Tên Section</span>
    <span class="sep">/</span>
    <span class="chapter-part">Tên Chapter</span>
  </div>

  <h2 class="section-heading">Giới thiệu</h2>
  <p>...</p>

  <h2 class="section-heading">Các tính năng chính</h2>
  <ul class="feature-list">
    <li>...</li>
  </ul>

  <h2 class="section-heading">Pricing</h2>
  <table class="pricing-table">
    <thead>
      <tr><th>No</th><th>Model </th><th>Giá (1M token) input</th></tr>
    </thead>
    <tbody>
      <tr><td>...</td><td>...</td><td class="price-value">$0.xx/unit</td></tr>
    </tbody>
  </table>

  <h2 class="section-heading">Use Cases</h2>
  <div class="usecase-grid">
    <div class="usecase-card">
      <h4>Tên use case</h4>
      <p>Mô tả...</p>
    </div>
  </div>

  <h2 class="section-heading">Thông tin bổ sung</h2>
  <p>...</p>

</body>
</html>
```

---

## Template mẫu — Bài Lab

```html
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Lab: TÊN LAB – Claude 101</title>
  <link rel="stylesheet" href="../../styles.css" />
  <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
  <script src="../../mermaid-config.js"></script>
  <link rel="stylesheet" href="../../prism.css" />
  <script src="../../prism.js"></script>
</head>
<body class="chapter-body">

  <div class="chapter-breadcrumb">
    <span class="section-part">N. Tên Section</span>
    <span class="sep">/</span>
    <span class="chapter-part">Lab: Tên Lab</span>
  </div>

  <h2 class="section-heading">Mục tiêu</h2>
  <ul class="feature-list">
    <li>...</li>
  </ul>

  <h2 class="section-heading">Kiến trúc tổng quan</h2>
  <div class="mermaid">
  flowchart LR
      subgraph OnPrem["🏢  On-Premises Data Center"]
          CorpAD["<img src='/aws-svg/data-center-icon.svg' style='width:40px;height:40px;'/><br/><b>Corporate Active Directory</b><br/>corp.example.com<br/><i>Domain Controllers · Users · GPOs</i>"]
      end
  </div>

  <h2 class="section-heading">Yêu cầu trước khi bắt đầu</h2>
  <ul class="feature-list">
    <li>Claude Code for windows: <code>...</code></li>
    <li>AWS CLI v2 đã cài đặt</li>
  </ul>

  <h2 class="section-heading">Các bước thực hành</h2>
  <ol class="step-list">
    <li>
      <div>
        <strong>Bước 1: Tên bước</strong>
        <p>Mô tả...</p>
        <pre class="command-line" data-prompt="$" data-output="2, 5"><code class="language-bash">aws service command \
  --param value \
  --region ap-southeast-1</code></pre>
      </div>
    </li>
  </ol>

  <!-- ⚠️ QUY TẮC QUAN TRỌNG: step-list flex layout
       .step-list > li là flex container (display: flex).
       Mọi phần tử con TRỰC TIẾP của <li> đều là flex item và xếp NGANG nhau.
       BẮT BUỘC: mỗi <li> chỉ có DUY NHẤT MỘT <div> con trực tiếp — tất cả nội dung
       (<pre>, <p>, <h4>, <div class="alert">, sub-section...) phải nằm BÊN TRONG div đó.

       ❌ SAI — <pre> là sibling của <div>, bị đẩy sang phải:
         <li>
           <div><strong>...</strong><p>...</p></div>
           <pre>...</pre>
         </li>

       ✅ ĐÚNG — <pre> nằm bên trong div duy nhất:
         <li>
           <div>
             <strong>...</strong>
             <p>...</p>
             <pre>...</pre>
           </div>
         </li>
  -->

  <h2 class="section-heading">Troubleshoot</h2>
  <div class="alert alert-warning">
    <strong>Lỗi:</strong> ... <br/>
    <strong>Nguyên nhân:</strong> ... <br/>
    <strong>Giải pháp:</strong> ...
  </div>

  <h2 class="section-heading">Dọn dẹp resource</h2>
  <div class="alert alert-info">Luôn xóa resource sau khi thực hành để tránh phát sinh chi phí.</div>
  <pre class="command-line" data-prompt="$" data-output="2, 5"><code class="language-bash">
  # Xóa toàn bộ infrastructure bằng Terraform (khuyến nghị)
  cd sourcecode/section_12/lab-sqs-sns-decoupling-system

  terraform destroy \
    -var 'sender_email=your-email@example.com' \
    -auto-approve
  </code>
  </pre>
  <script>mermaid.initialize({ startOnLoad: true, theme: 'default' });</script>
</body>
</html>
```

---

## Quy ước đặt tên file

| Loại | Đường dẫn | Ví dụ |
|---|---|---|
| Chapter nội dung | `sections/section_N/chapter_M.html` | `sections/section_3/chapter_5.html` |
| Source code lab | `sourcecode/section_N/lab_<tên>/` | `sourcecode/section_9/lab_claude_code_and_aws/` |
| Terraform entry point | `sourcecode/section_N/lab_<tên>/main.tf` | snake_case |
| Shell script | `sourcecode/section_N/lab_<tên>/commands.sh` | snake_case |

---

## Không làm

- Không thêm sidebar/header vào chapter file — đây là nội dung iframe.
- Không rút gọn command trong bài lab — học viên cần copy-paste được ngay.
- Không sử dụng inline-css, cố gắng tái sử dụng các class có sẵn trong styles.css, chỉ thêm vào khi cần thiết.
- **Không đặt `<pre>`, `<p>`, `<h4>`, hay bất kỳ element nào là con trực tiếp của `<li class="step-list">` ngoài một `<div>` duy nhất.** `.step-list > li` là flex container — mọi con trực tiếp của `<li>` đều trở thành flex item và xếp ngang nhau, khiến code block bị đẩy sang phải. Toàn bộ nội dung (bao gồm `<pre>`, sub-header `<h4>`, alert `<div>`) phải nằm bên trong div wrapper duy nhất đó.