# Claude 101 – From Zero to Hero (Tiếng Việt)

**Đối tượng học viên:** Người mới bắt đầu, không yêu cầu kiến thức nền tảng. Phù hợp với dân IT (Developer, Tester, DevOps Engineer, Cloud Engineer, Project Manager) muốn ứng dụng Claude vào công việc hằng ngày.

**Level:** Beginner

**Ngôn ngữ:** Tiếng Việt

> **Lưu ý:** File này phản ánh đúng cấu trúc chương/bài hiện có trong `index.html` (sidebar navigation). Khi thêm/sửa/xoá chapter trong `index.html`, cập nhật lại file này tương ứng.

---

## Section 1. Giới thiệu về giảng viên & khoá học

### Nội dung chính
Làm quen với giảng viên, hiểu rõ mục tiêu khoá học, yêu cầu đầu vào và cách tương tác trong suốt quá trình học.

### Danh sách chapter
1. Giới thiệu giảng viên Linh Nguyễn
2. Nội dung khóa học & Mục tiêu sau khi hoàn thành
3. Yêu cầu đầu vào & Lưu ý trong quá trình học
4. Tương tác với giảng viên như thế nào?

---

## Section 2. Làm quen với Claude

### Nội dung chính
Giới thiệu hệ sinh thái sản phẩm Claude: Claude là gì, các giao diện sử dụng (Desktop App, Claude Code, Cowork, Design), cách viết prompt hiệu quả và tối ưu chi phí. Đây là section thực hành nhiều nhất, giúp học viên có đầy đủ công cụ trước khi bước vào các section chuyên biệt theo vai trò công việc.

### Danh sách chapter
1. Lab - Cài đặt Claude Desktop & Claude Code (Windows)
2. Những hiểu lầm về các công cụ Generative AI
3. Claude là gì? LLM & các dòng model (Haiku/Sonnet/Opus)
4. Claude Desktop App — Chat, Projects & Artifacts
5. Claude Code — CLI, khác biệt so với chat thông thường
6. Claude Cowork
7. Claude Design
8. Nguyên tắc viết prompt hiệu quả & mẹo tối ưu chi phí
9. Lab - Thao tác cơ bản với Claude trên máy local
10. Lab - Sử dụng Claude Cowork
11. Lab - Sử dụng Claude Design
12. Lab - Claude Code qua CLI: Plan, Auto-mode, Accept Edit
13. Lab - Viết CLAUDE.md cho project mẫu

---

## Section 3. Claude Skills & Agent

### Nội dung chính
Đi sâu vào các khái niệm mở rộng khả năng của Claude: Skills (kỹ năng tái sử dụng), Agent/Sub-agent (tác vụ tự động, chuyên biệt hoá), cách cài đặt Anthropic Skills có sẵn và tự tạo custom slash command.

### Danh sách chapter
1. Claude Skills là gì?
2. Lab - Tạo một Claude Skill
3. Agent/Sub-Agent là gì?
4. Lab - Tạo một Claude Sub-Agent
5. Lab - Cài đặt Anthropic Skills có sẵn
6. Lab - Custom slash command (/)

---

## Section 4. Claude Code cho Developer

### Nội dung chính
Ứng dụng Claude Code vào quy trình phát triển phần mềm hàng ngày, xuyên suốt bằng một project mẫu **Expense Management** (Next.js + Prisma + MySQL): khởi tạo project, tổ chức quy tắc làm việc qua CLAUDE.md, nâng cấp quy trình bằng Skill/Sub-Agent, tích hợp Git để review pull request tự động, và triển khai lên Cloud.

### Danh sách chapter
1. Giới thiệu chương
2. Quy trình làm việc chuẩn: Explore → Plan → Code → Verify
3. Lab - Khởi tạo project Expense Management (Next.js + Prisma + MySQL)
4. Lab - Tổ chức project và định nghĩa quy tắc làm việc thông qua CLAUDE.md
5. Lab - Nâng cấp quy trình làm việc với Skill và Sub-Agent
6. Tích hợp Git với Claude Code (giới hạn & rủi ro)
7. Lab - Tích hợp Claude Code với Git để review pull request tự động
8. Lab - Triển khai hệ thống lên dịch vụ Cloud

---

## Section 5. Claude cho Tester / QA

### Nội dung chính
Ứng dụng Claude vào công việc kiểm thử phần mềm: sinh test case, viết test tự động cho function/API, viết bug report, và test end-to-end với Playwright — thực hành trên project Expense Management ở Section 4.

### Danh sách chapter
1. Claude trong Testing & Quality Assurance
2. Lab - Sinh bộ test case từ requirement
3. Lab - Viết test tự động cho function/API có sẵn
4. Lab - Viết bug report hoàn chỉnh
5. Lab - Test tự động end-to-end với Playwright

---

## Section 6. Claude cho DevOps & Cloud Engineer

### Nội dung chính
Ứng dụng Claude/Claude Code trong công việc vận hành hạ tầng: vai trò và nguyên tắc an toàn khi để AI thao tác hạ tầng, viết Infrastructure as Code (Terraform), tích hợp CI/CD, đóng gói quy ước thiết kế kiến trúc AWS và sinh Terraform thành Claude Skill riêng, triển khai CI/CD thực tế trên AWS CodePipeline.

### Danh sách chapter
1. Vai trò Claude trong vòng đời DevOps & nguyên tắc an toàn
2. Cách cấu trúc prompt cho Infrastructure as Code (Terraform)
3. Tích hợp Claude Code vào pipeline CI/CD
4. Lab - Thiết kế hạ tầng hệ thống trên AWS sử dụng Claude (Skill `aws-architecture-design`)
5. Lab - Tự động hóa triển khai hạ tầng sử dụng Terraform (Skill `terraform-aws-generator`)
6. Lab - Implement CI/CD trên AWS CodePipeline với Claude

---

## Section 7. Claude cho Project Manager

### Nội dung chính
Ứng dụng Claude trong quản lý dự án: vai trò của Claude trong công việc quản lý, soạn thảo kế hoạch dự án và ước lượng (estimation).

### Danh sách chapter
1. Vai trò Claude trong quản lý dự án
2. Lab - Soạn thảo kế hoạch dự án & estimation

---

## Section 8. Model Context Protocol (MCP)

### Nội dung chính
Giới thiệu Model Context Protocol (MCP) — chuẩn giao tiếp giúp Claude Code kết nối và thao tác với các hệ thống/công cụ bên ngoài. Thực hành cấu hình MCP Server CodeGraph để phân tích quan hệ code, và MCP Server MySQL để kiểm chứng dữ liệu sau khi Claude Code thao tác trên project Expense Management.

### Danh sách chapter
1. Giới thiệu về MCP
2. MCP Server local vs remote & rủi ro bảo mật
3. Các MCP Server phổ biến (filesystem, Git, database, CodeGraph)
4. Lab - Cấu hình MCP Server CodeGraph
5. Lab - Cấu hình MCP Server MySQL & kiểm chứng dữ liệu

---

## Section 9. Claude Code Hooks

### Nội dung chính
Giới thiệu cơ chế Hook trong Claude Code — cho phép "chèn" shell command tuỳ chỉnh vào các thời điểm cố định trong vòng đời một phiên làm việc (trước/sau khi gọi tool, khi kết thúc phiên...). Thực hành cấu hình Hook `PostToolUse` tự động format code và Hook `Stop` gửi thông báo, trên project `lab-expense-management`.

### Danh sách chapter
1. Giới thiệu về Hook
2. Các loại event Hook & cấu trúc khai báo trong settings.json
3. Lab - Cấu hình Hook PostToolUse tự động format code
4. Lab - Cấu hình Hook Stop gửi thông báo
5. Lab - Cấu hình Hook chặn hành động nguy hiểm (xoá file, git push/reset)

---

## Section 10. Phát triển phần mềm với Spec-Kit Framework

### Nội dung chính
Giới thiệu Spec-Kit — framework mã nguồn mở của GitHub cho phương pháp Spec-Driven Development (SDD), kết hợp Claude Code để phát triển phần mềm có kiểm soát: từ constitution, đặc tả yêu cầu, lập kế hoạch kỹ thuật, chia nhỏ task, đến triển khai và deploy lên Cloud.

### Danh sách chapter
1. Spec-Driven Development (SDD) là gì
2. Giới thiệu Spec-Kit Framework
3. Lab - Cài đặt & khởi tạo project với `specify init`
4. Lab - Constitution & Specify cho tính năng mới
5. Lab - Plan & Tasks
6. Lab - Implement & đối chiếu kết quả
7. Lab - Triển khai lên dịch vụ Cloud
8. Tổng kết Spec-Driven Development

---

## Section 11. Harness Engineering

### Nội dung chính
Giới thiệu Harness Engineering — kỹ thuật xây dựng mọi thứ **xung quanh model** (context, tools, permissions, memory, kiểm chứng, quan sát) để AI agent làm việc đáng tin cậy. Công thức cốt lõi: **Agent = Model + Harness**. Phần thực hành xây dựng **một website bất động sản hoàn toàn mới** (Next.js + Prisma + PostgreSQL/docker-compose, 4 role: BUYER, SELLER, MODERATOR, SYSTEM_ADMIN) và **bổ sung dần từng thành phần harness** (Prompt → Context → Sensor → Hook & Test → Phân quyền → Skill & Sub-agent → Memory/State → Quan sát & cải tiến). Ở mỗi Lab, học viên chỉ đi theo **một con đường đúng**: nhờ Claude thêm thành phần harness, thêm tính năng bằng prompt ngắn, rồi đo bằng `scorecard.ps1`; nếu điểm có dấu hiệu bất thường thì bổ sung đúng một quy tắc harness cần thiết. Các thành phần harness được **nhờ Claude viết** (không copy-paste) để học viên hình dung cách thêm từng thành phần. Không bao gồm Infrastructure/Cloud/DevOps.

### Danh sách chapter
1. Harness Engineering là gì? Agent = Model + Harness (từ Prompt Engineering → Context Engineering → Harness Engineering)
2. Các thành phần của Harness & ánh xạ vào Claude Code (CLAUDE.md, Skills, Sub-agent, MCP, Hooks, Permissions)
3. Guides & Sensors: feedforward và feedback trong thiết kế Harness (computational vs inferential), nguyên tắc thiết kế và rủi ro
4. Lab 0 - Khởi tạo project bất động sản (Next.js, Prisma, PostgreSQL) + `scorecard.ps1`
5. Lab 1 - Chỉ dùng Prompt Engineering
6. Lab 2 - Thêm Context (CLAUDE.md & docs/)
7. Lab 3 - Thêm Sensor kiểm tra kiến trúc
8. Lab 4 - Vòng phản hồi tự động với Test & Hooks
9. Lab 5 - Ma trận phân quyền & giới hạn quyền của agent
10. Lab 6 - Skill & Sub-agent reviewer
11. Lab 7 - Harness cho tác vụ dài hơi (nhiều phiên)
12. Lab 8 - Quan sát, cải tiến & tổng kết hành trình

### Project thực hành xuyên suốt
`D:\lab-realestate` — website bất động sản độc lập với các project ở Section 4–10 để mọi thí nghiệm bắt đầu "sạch". Source code mẫu: `sourcecode/section_11/lab_realestate/` (file nền tảng + thư mục `reference/` chứa đáp án tham khảo của các thành phần harness).

### Nguồn tham khảo định nghĩa
Công thức "Agent = Model + Harness" (LangChain), thuật ngữ do Mitchell Hashimoto dùng từ 02/2026, bài "Harness engineering" của OpenAI (02/2026), bài của Böckeler trên martinfowler.com (guides & sensors), bài "Effective harnesses for long-running agents" của Anthropic (11/2025), và tài liệu học thuật arXiv về "AI Harness Engineering".

---

## Section 12. Tổng kết & Định hướng nâng cao

### Nội dung chính
Ôn tập toàn bộ kiến thức đã học, xây dựng lộ trình ứng dụng Claude vào công việc thực tế của từng học viên, giới thiệu hướng học nâng cao (Claude API, Claude Agent SDK).

### Danh sách chapter
1. Tổng hợp công cụ đã học & khi nào dùng cái gì
2. Định hướng nâng cao: Claude API / Claude Agent SDK
3. Bài tập tổng hợp cuối khoá

---

## Tổng quan cấu trúc khoá học

| Section | Tên chương | Số chapter |
|---|---|---|
| 1 | Giới thiệu giảng viên & khoá học | 4 |
| 2 | Làm quen với Claude | 13 |
| 3 | Claude Skills & Agent | 6 |
| 4 | Claude Code cho Developer | 8 |
| 5 | Claude cho Tester / QA | 5 |
| 6 | Claude cho DevOps & Cloud Engineer | 6 |
| 7 | Claude cho Project Manager | 2 |
| 8 | Model Context Protocol (MCP) | 5 |
| 9 | Claude Code Hooks | 4 |
| 10 | Phát triển phần mềm với Spec-Kit Framework | 8 |
| 11 | Harness Engineering | 12 |
| 12 | Tổng kết & Định hướng nâng cao | 3 |
| **Tổng** | | **76 chapter** |
