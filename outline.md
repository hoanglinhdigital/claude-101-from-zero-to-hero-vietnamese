# Claude 101 – From Zero to Hero (Tiếng Việt)

**Đối tượng học viên:** Người mới bắt đầu, không yêu cầu kiến thức nền tảng. Phù hợp với dân IT (Developer, Tester, DevOps Engineer, Cloud Engineer, Project Manager) muốn ứng dụng Claude vào công việc hằng ngày.

**Level:** Beginner

**Ngôn ngữ:** Tiếng Việt

**Tổng thời lượng dự kiến:** 12–14 giờ (video lý thuyết + thực hành)

---

## Section 1. Giới thiệu về giảng viên & khoá học

**Thời lượng dự kiến:** 20–30 phút

### Nội dung chính
Làm quen với giảng viên, hiểu rõ mục tiêu khoá học, yêu cầu đầu vào và cách tương tác trong suốt quá trình học.

### Kết quả kỳ vọng đạt được
- Nắm được lộ trình học và những gì sẽ đạt được sau khoá học.
- Biết cách đặt câu hỏi, tìm tài liệu hỗ trợ khi gặp khó khăn.

### Nội dung
**Lý thuyết:**
1. Giới thiệu giảng viên Linh Nguyễn — kinh nghiệm, chuyên môn liên quan đến AI/Cloud.
2. Tổng quan nội dung khoá học và mục tiêu sau khi hoàn thành.
3. Yêu cầu đầu vào (không cần kiến thức lập trình sâu, chỉ cần máy tính + tài khoản Anthropic).
4. Lưu ý trong quá trình học: tốc độ học, cách thực hành song song với lý thuyết.
5. Kênh tương tác với giảng viên: hỏi đáp, cộng đồng, hỗ trợ khi gặp lỗi.

**Thực hành:** Hướng dẫn học viên tạo tài khoản Anthropic (Claude.ai) và Anthropic Console để chuẩn bị cho các chương sau.

### Tổng kết chương
Học viên hiểu rõ bức tranh tổng thể khoá học, đã chuẩn bị sẵn tài khoản cần thiết để bắt đầu thực hành từ Section 2.

---

## Section 2. Làm quen với Claude

**Thời lượng dự kiến:** 2 – 2.5 giờ

### Nội dung chính
Giới thiệu hệ sinh thái sản phẩm Claude: Claude là gì, các giao diện sử dụng (web, desktop app, Claude Code, Claude Projects), cách viết prompt hiệu quả và tối ưu chi phí.

### Kết quả kỳ vọng đạt được
- Phân biệt được các sản phẩm trong hệ sinh thái Claude và biết khi nào dùng công cụ nào.
- Cài đặt và sử dụng thành thạo Claude Desktop App, Claude Code ở mức cơ bản.
- Biết cách viết file CLAUDE.md (system prompt) để tuỳ biến hành vi của Claude Code.
- Áp dụng được các mẹo tiết kiệm chi phí khi sử dụng Claude.

### Nội dung
**Lý thuyết:**
1. Cài đặt Claude Desktop, ClaudeCode (Windows) và login bằng tài khoản Anthropic.
2. Claude là gì — mô hình ngôn ngữ lớn (LLM), các dòng model (Haiku, Sonnet, Opus) và use case tương ứng.
3. Claude Desktop App — giao diện chat, tính năng Projects, Artifacts.
4. Claude Code — trợ lý lập trình dòng lệnh (CLI), khác biệt so với chat thông thường.
5. Claude Cowork & Claude Design — cộng tác nhóm và các công cụ hỗ trợ thiết kế/tài liệu.
6. Nguyên tắc viết prompt hiệu quả và các mẹo tối ưu chi phí (chọn model phù hợp, prompt caching, giới hạn context).

**Thực hành:**
- Lab 1: Thao tác cơ bản với Claude trên máy local, thực hiện các lệnh cơ bản (khởi tạo project, hỏi đáp, chỉnh sửa file).
- Lab 2: Thao tác cơ bản với Claude Code thông qua Command line. Conversation mode: Plan, Auto-mode, Accept Edit.
- Lab 2: Viết file CLAUDE.md cho một project mẫu để tuỳ chỉnh system prompt.

### Tổng kết chương
Học viên đã có công cụ (Claude Desktop App + Claude Code) sẵn sàng sử dụng, hiểu cách cấu hình cơ bản và biết cách tiết kiệm chi phí khi vận hành.

---

## Section 3. Claude Skills & Agent

**Thời lượng dự kiến:** 1.5 – 2 giờ

### Nội dung chính
Đi sâu vào hai khái niệm mở rộng khả năng của Claude: Skills (kỹ năng tái sử dụng) và Agent/Sub-agent (tác vụ tự động, chuyên biệt hoá).

### Kết quả kỳ vọng đạt được
- Hiểu khái niệm Claude Skill và tự tạo được một Skill đơn giản.
- Hiểu khái niệm Agent/Sub-agent và biết khi nào nên tách sub-agent riêng.
- Tự xây dựng được một Sub-agent phục vụ công việc cụ thể (vd: code review, viết test).

### Nội dung
**Lý thuyết:**
1. Claude Skill là gì — cấu trúc thư mục, file SKILL.md, cách Claude phát hiện và gọi skill.
2. Phân biệt Skill và Prompt thông thường — khi nào nên đóng gói thành Skill.
3. Claude Agent/Sub-agent là gì — vai trò, phạm vi công cụ (tools) riêng biệt.
4. Kiến trúc phối hợp giữa Agent chính và Sub-agent (orchestration).
5. Best practice khi thiết kế Skill/Agent: đặt tên, mô tả rõ trigger, giới hạn phạm vi.

**Thực hành:**
- Lab 1: Tạo một Claude Skill tuỳ chỉnh (vd: skill tạo changelog hoặc format code).
- Lab 2: Tạo một Sub-agent chuyên biệt (vd: sub-agent chuyên review code hoặc viết test case).

### Tổng kết chương
Học viên có thể mở rộng năng lực của Claude bằng Skill và Sub-agent, áp dụng vào quy trình làm việc thực tế thay vì chỉ chat đơn thuần.

---

## Section 4. Claude Code cho lập trình viên (Developer)

**Thời lượng dự kiến:** 1.5 giờ

### Nội dung chính
Ứng dụng Claude Code vào quy trình phát triển phần mềm hàng ngày: Khởi tạo project từ zero, đọc hiểu codebase sẵn có, viết tính năng mới, refactor, debug.

### Kết quả kỳ vọng đạt được
- Sử dụng Claude Code để khởi tạo một base project mới trong thời gian ngắn (Vd project Next.js)
- Sử dụng Claude Code để đọc hiểu một codebase lạ trong thời gian ngắn.
- Dùng Claude Code để implement một tính năng nhỏ theo yêu cầu (feature request).
- Biết cách yêu cầu Claude Code refactor và tự viết unit test.
- Biết cách yêu cầu Claude Code Viết API end-to-end testing sử dụng Grafana K6 script.

### Nội dung
**Lý thuyết:**
1. Quy trình làm việc chuẩn với Claude Code: explore → plan → code → verify.
2. Cách đặt câu hỏi để Claude Khởi tạo project mới sử dụng các ngôn ngữ và framework được chỉ định (Vd: NextJS, Python Fast API).
2. Cách đặt câu hỏi để Claude "đọc" và tóm tắt kiến trúc codebase từ một repository sẵn có.
3. Kỹ thuật viết yêu cầu (prompt) rõ ràng cho tác vụ code (feature, bugfix, refactor).
4. Giới hạn và rủi ro: khi nào cần review kỹ, khi nào tin tưởng Claude tự chạy.
5. Tích hợp Claude Code với Git (commit, PR description, code review hỗ trợ).

**Thực hành:**
- Lab 1: Dùng Claude Code Tạo mới một project sử dụng tech stack Nextjs, gồm backend và frontend, database sử dụng Prisma + MySQL. Deploy local sử dụng Docker cho database để làm demo. Yêu cầu Claude Code implement một số tính năng cơ bản ví dụ App Quản lý chi tiêu (Expense management).
- Lab 2: Dùng Claude Code khám phá một repository mã nguồn mở, tóm tắt kiến trúc.
- Lab 3: Yêu cầu Claude Code thêm một tính năng nhỏ + viết unit test cho tính năng đó.
- Lab 4: Yêu cầu Claude Code refactor một đoạn code và tạo Pull Request.

### Tổng kết chương
Học viên áp dụng được Claude Code vào vòng đời phát triển phần mềm thực tế: từ tìm hiểu code, viết tính năng, đến refactor và tạo PR.

---

## Section 5. Claude cho DevOps & Cloud Engineer

**Thời lượng dự kiến:** 1.5 giờ

### Nội dung chính
Ứng dụng Claude/Claude Code trong công việc vận hành hạ tầng: viết Infrastructure as Code (Terraform), script tự động hoá, phân tích log, hỗ trợ CI/CD.

### Kết quả kỳ vọng đạt được
- Dùng Claude Code sinh và review file Terraform cơ bản.
- Dùng Claude viết script tự động hoá (bash/PowerShell) cho tác vụ vận hành thường gặp.
- Dùng Claude để phân tích log lỗi và đề xuất hướng xử lý sự cố.

### Nội dung
**Lý thuyết:**
1. Vai trò của Claude trong vòng đời DevOps: plan – provision – deploy – monitor.
2. Nguyên tắc an toàn khi để AI thao tác hạ tầng (review trước khi apply, tránh lệnh destructive).
3. Cách cấu trúc prompt cho tác vụ IaC (Terraform/CloudFormation).
4. Dùng Claude hỗ trợ phân tích log và troubleshooting sự cố.
5. Tích hợp Claude Code vào pipeline CI/CD (gợi ý, không tự động hoá hoàn toàn).

**Thực hành:**
- Lab 1: Dùng Claude Code sinh file Terraform tạo hạ tầng cơ bản (vd: VPC, EC2, DynamoDB Table, S3 bucket, IAM policy), review kỹ trước khi apply.
- Lab 2: Viết script tự động hoá một tác vụ vận hành lặp lại (vd: backup, dọn log).
- Lab 3: Đưa một đoạn log lỗi thực tế, dùng Claude phân tích nguyên nhân và đề xuất fix.

### Tổng kết chương
Học viên biết cách dùng Claude như một trợ lý DevOps: hỗ trợ viết IaC, tự động hoá script, và phân tích sự cố — luôn kèm nguyên tắc review an toàn.

---

## Section 6. Claude cho Tester / QA

**Thời lượng dự kiến:** 1 – 1.5 giờ

### Nội dung chính
Ứng dụng Claude vào công việc kiểm thử phần mềm: sinh test case, viết test script tự động, phân tích bug report.

### Kết quả kỳ vọng đạt được
- Dùng Claude sinh bộ test case từ một yêu cầu chức năng (requirement).
- Dùng Claude Code viết test tự động (unit test/integration test) cho một chức năng có sẵn.
- Dùng Claude hỗ trợ viết bug report rõ ràng, dễ tái hiện lỗi.

### Nội dung
**Lý thuyết:**
1. Vai trò Claude trong quy trình QA: từ phân tích requirement đến sinh test case.
2. Kỹ thuật prompt để sinh test case bao phủ đầy đủ case (happy path, edge case, negative case).
3. Dùng Claude Code để viết test tự động (Selenium/Playwright/unit test framework).
4. Dùng Claude phân tích kết quả test fail và gợi ý nguyên nhân gốc rễ.
5. Viết bug report chuẩn với sự hỗ trợ của Claude (mô tả, bước tái hiện, mức độ ưu tiên).

**Thực hành:**
- Lab 1: Từ một requirement mẫu, dùng Claude sinh bộ test case đầy đủ (happy path + edge case).
- Lab 2: Dùng Claude Code viết một test tự động đơn giản cho một hàm/API có sẵn.
- Lab 3: Dùng Claude viết bug report hoàn chỉnh từ mô tả lỗi ngắn gọn của học viên.

### Tổng kết chương
Học viên biết ứng dụng Claude để tăng tốc độ và chất lượng công việc kiểm thử, từ thiết kế test case đến viết bug report chuyên nghiệp.

---

## Section 7. Claude cho Project Manager

**Thời lượng dự kiến:** 1 giờ

### Nội dung chính
Ứng dụng Claude trong quản lý dự án: soạn thảo tài liệu, tóm tắt cuộc họp, lập kế hoạch, theo dõi tiến độ.

### Kết quả kỳ vọng đạt được
- Dùng Claude soạn thảo tài liệu dự án (kế hoạch, báo cáo tiến độ) nhanh chóng.
- Dùng Claude tóm tắt biên bản họp và trích xuất action items.
- Dùng Claude hỗ trợ phân tích rủi ro và đề xuất giải pháp trong dự án.

### Nội dung
**Lý thuyết:**
1. Vai trò của Claude trong quản lý dự án: soạn thảo, tổng hợp, ra quyết định hỗ trợ.
2. Kỹ thuật prompt cho tài liệu quản lý (kế hoạch dự án, risk register, status report).
3. Dùng Claude Projects để lưu trữ ngữ cảnh dự án xuyên suốt nhiều buổi làm việc.
4. Tóm tắt cuộc họp và trích xuất action items từ transcript/ghi chú.
5. Giới hạn cần lưu ý: Claude hỗ trợ ra quyết định, không thay thế vai trò quản lý.

**Thực hành:**
- Lab 1: Dùng Claude soạn một bản kế hoạch dự án (project plan) từ mô tả ngắn gọn.
- Lab 2: Đưa một đoạn transcript họp mẫu, dùng Claude tóm tắt và liệt kê action items.
- Lab 3: Dùng Claude Projects để quản lý ngữ cảnh cho một dự án giả lập xuyên suốt nhiều buổi.

### Tổng kết chương
Học viên biết áp dụng Claude để tăng hiệu suất công việc quản lý dự án: soạn tài liệu, tóm tắt họp, và theo dõi tiến độ nhất quán.

---

## Section 8. Model Context Protocol (MCP) — Kết nối Claude với hệ thống bên ngoài

**Thời lượng dự kiến:** 1.5 – 2 giờ

### Nội dung chính
Giới thiệu Model Context Protocol (MCP) — chuẩn giao tiếp giúp Claude Code kết nối và thao tác với các hệ thống/công cụ bên ngoài (codebase, database, API nội bộ...). Thực hành cấu hình một MCP Server giúp Claude đọc hiểu quan hệ giữa các thành phần code (CodeGraph) và một MCP Server kết nối MySQL để kiểm chứng dữ liệu sau khi Claude Code thao tác.

### Kết quả kỳ vọng đạt được
- Hiểu MCP là gì, vấn đề nó giải quyết, và mô hình kiến trúc Client – Host – Server của MCP.
- Biết cách cấu hình một MCP Server trong Claude Code (`claude mcp add`, file cấu hình `.mcp.json`).
- Sử dụng MCP Server dạng CodeGraph để Claude hiểu mối liên hệ (dependency, call graph) giữa các file/module trước khi sửa một tính năng, giảm rủi ro sửa sai chỗ.
- Sử dụng MCP Server kết nối MySQL để Claude Code tự truy vấn database, kiểm chứng xem một tính năng (vd: tạo/sửa/xoá dữ liệu) có thực sự thao tác đúng trên database hay không.

### Nội dung
**Lý thuyết:**
1. Model Context Protocol (MCP) là gì — chuẩn mở do Anthropic công bố, vai trò như "USB-C cho AI Agent".
2. Kiến trúc MCP: MCP Host (Claude Code/Claude Desktop), MCP Client, MCP Server, và các primitives (Tools, Resources, Prompts).
3. Phân biệt MCP Server local (chạy qua stdio) và remote (chạy qua HTTP/SSE).
4. Rủi ro bảo mật khi cấp quyền cho MCP Server (phạm vi truy cập, dữ liệu nhạy cảm, nguyên tắc least privilege).
5. Giới thiệu một số MCP Server phổ biến: filesystem, Git, database (MySQL/Postgres), CodeGraph (phân tích quan hệ code).

**Thực hành:**
- Lab 1: Cấu hình MCP Server CodeGraph cho một project mẫu, dùng Claude Code truy vấn quan hệ (call graph, dependency) giữa các module trước khi yêu cầu sửa một tính năng.
- Lab 2: Cấu hình MCP Server kết nối MySQL (dùng lại project Expense Management ở Section 4). Yêu cầu Claude Code thực hiện một thao tác ghi dữ liệu (thêm khoản chi tiêu), sau đó dùng chính MCP Server MySQL để Claude tự truy vấn và xác nhận dữ liệu đã được ghi đúng.

### Tổng kết chương
Học viên biết cách mở rộng khả năng của Claude Code ra ngoài phạm vi file local, kết nối với codebase phức tạp và database thực tế thông qua MCP, đồng thời hiểu các nguyên tắc an toàn khi cấp quyền truy cập.

---

## Section 9. Claude Code Hooks — Tự động hoá vòng đời làm việc

**Thời lượng dự kiến:** 1 giờ

### Nội dung chính
Giới thiệu cơ chế Hook trong Claude Code — cho phép chạy tự động các đoạn script tại những thời điểm nhất định trong vòng đời một phiên làm việc (trước/sau khi gọi tool, khi kết thúc phiên...).

### Kết quả kỳ vọng đạt được
- Hiểu khái niệm Hook, phân biệt với Skill và Sub-agent.
- Biết các loại event Hook phổ biến (PreToolUse, PostToolUse, Stop, SessionStart...) và thời điểm chúng được kích hoạt.
- Tự cấu hình được một Hook đơn giản trong file cấu hình của Claude Code.

### Nội dung
**Lý thuyết:**
1. Hook là gì — cơ chế "chèn" shell command vào vòng đời làm việc của Claude Code, chạy độc lập với model.
2. Các loại event Hook chính: `PreToolUse`, `PostToolUse`, `UserPromptSubmit`, `Stop`, `SessionStart`.
3. Cấu trúc khai báo Hook trong `settings.json` (matcher theo tên tool, command thực thi).
4. Use case thực tế: tự động format code sau khi Claude chỉnh sửa file, chặn lệnh nguy hiểm trước khi thực thi, gửi thông báo khi Claude hoàn thành tác vụ.
5. Lưu ý an toàn: Hook chạy với quyền của người dùng, cần review kỹ trước khi thêm hook chạy tự động.

**Thực hành:**
- Lab 1: Cấu hình một Hook `PostToolUse` đơn giản — tự động chạy formatter (vd: Prettier/Black) mỗi khi Claude Code chỉnh sửa file.
- Lab 2: Cấu hình một Hook `Stop` gửi thông báo (vd: ghi log hoặc hiện popup) khi Claude Code hoàn thành một tác vụ dài.

### Tổng kết chương
Học viên hiểu cách dùng Hook để tự động hoá các bước lặp lại và tăng cường kiểm soát an toàn trong quy trình làm việc với Claude Code.

---

## Section 10. Phát triển phần mềm với Spec-Kit Framework

**Thời lượng dự kiến:** 1.5 giờ

### Nội dung chính
Giới thiệu Spec-Kit — framework mã nguồn mở của GitHub cho phương pháp Spec-Driven Development (SDD), kết hợp với Claude Code để phát triển phần mềm có kiểm soát: từ đặc tả yêu cầu, lập kế hoạch kỹ thuật, chia nhỏ task, đến triển khai.

### Kết quả kỳ vọng đạt được
- Hiểu triết lý Spec-Driven Development: đặc tả (specification) là nguồn chân lý (source of truth), không phải tài liệu phụ trợ.
- Cài đặt và khởi tạo được một project sử dụng Spec-Kit tích hợp với Claude Code.
- Sử dụng thành thạo các slash command chính: `/speckit.constitution`, `/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, `/speckit.implement`.
- Áp dụng được quy trình SDD để phát triển một tính năng nhỏ có kiểm soát, giảm rủi ro "vibe coding".

### Nội dung
**Lý thuyết:**
1. Spec-Driven Development (SDD) là gì — vì sao đặc tả trở thành artifact thực thi thay vì tài liệu bỏ đi sau khi code xong.
2. Giới thiệu Spec-Kit (github.com/github/spec-kit) — công cụ CLI `specify`, yêu cầu cài đặt (Python 3.11+, Git, `uv`).
3. Các giai đoạn trong quy trình SDD: Constitution → Specification → Planning → Task Breakdown → Implementation → Convergence.
4. Cấu trúc file sinh ra bởi Spec-Kit: `.specify/memory/constitution.md`, `specs/{feature-id}/spec.md`, `plan.md`, `tasks.md`.
5. Cách Claude Code sử dụng các slash command `/speckit.*` để thực thi từng giai đoạn, giữ ngữ cảnh xuyên suốt từ đặc tả đến code.

**Thực hành:**
- Lab 1: Cài đặt `specify` CLI, khởi tạo project mới với `specify init` tích hợp Claude Code.
- Lab 2: Dùng `/speckit.constitution` và `/speckit.specify` để định nghĩa nguyên tắc dự án và đặc tả một tính năng (vd: thêm chức năng xuất báo cáo cho app Expense Management ở Section 4).
- Lab 3: Dùng `/speckit.plan` và `/speckit.tasks` để lập kế hoạch kỹ thuật và chia nhỏ task.
- Lab 4: Dùng `/speckit.implement` để Claude Code triển khai tính năng theo đúng task đã chia, đối chiếu kết quả với đặc tả ban đầu.

### Tổng kết chương
Học viên biết cách áp dụng phương pháp Spec-Driven Development kết hợp Claude Code để phát triển tính năng có kiểm soát, dễ kiểm chứng và giảm rủi ro sai lệch so với yêu cầu ban đầu.

---

## Section 11. Tổng kết khoá học & Định hướng nâng cao

**Thời lượng dự kiến:** 30–45 phút

### Nội dung chính
Ôn tập toàn bộ kiến thức đã học, xây dựng lộ trình ứng dụng Claude vào công việc thực tế của từng học viên, giới thiệu hướng học nâng cao (Claude API, Claude Agent SDK).

### Kết quả kỳ vọng đạt được
- Hệ thống hoá lại toàn bộ kiến thức từ Section 1 đến Section 10.
- Tự xây dựng được lộ trình cá nhân hoá để áp dụng Claude vào công việc hằng ngày.
- Biết các hướng học tiếp theo nếu muốn đi sâu hơn (Claude API, Claude Agent SDK).

### Nội dung
**Lý thuyết:**
1. Tổng hợp lại các công cụ đã học: Claude Desktop, Claude Code, Skills, Sub-agent, MCP, Hooks, Spec-Kit.
2. So sánh nhanh: khi nào dùng chat thường, khi nào dùng Claude Code, khi nào cần Agent riêng, khi nào cần MCP/Hook/Spec-Kit.
3. Giới thiệu hướng nâng cao: Claude API/Anthropic SDK cho lập trình viên muốn tích hợp sâu.
4. Gợi ý xây dựng thói quen sử dụng Claude hằng ngày trong công việc.

**Thực hành:**
- Bài tập tổng hợp: học viên chọn một bài toán thực tế trong công việc của mình và tự thiết kế + thực hiện giải pháp bằng Claude/Claude Code (có thể kết hợp Skill hoặc Sub-agent đã học).

### Tổng kết chương
Học viên có cái nhìn tổng thể về hệ sinh thái Claude, tự tin ứng dụng vào công việc hằng ngày và biết hướng đi tiếp theo nếu muốn nâng cao kỹ năng.

---

## Tổng quan thời lượng

| Section | Tên chương | Thời lượng dự kiến |
|---|---|---|
| 1 | Giới thiệu giảng viên & khoá học | 0.3 – 0.5 giờ |
| 2 | Làm quen với Claude | 2 – 2.5 giờ |
| 3 | Claude Skills & Agent | 1.5 – 2 giờ |
| 4 | Claude Code cho Developer | 1.5 giờ |
| 5 | Claude cho DevOps & Cloud Engineer | 1.5 giờ |
| 6 | Claude cho Tester/QA | 1 – 1.5 giờ |
| 7 | Claude cho Project Manager | 1 giờ |
| 8 | Model Context Protocol (MCP) | 1.5 – 2 giờ |
| 9 | Claude Code Hooks | 1 giờ |
| 10 | Phát triển phần mềm với Spec-Kit Framework | 1.5 giờ |
| 11 | Tổng kết & Định hướng nâng cao | 0.5 – 0.75 giờ |
| **Tổng** | | **~13 – 15.25 giờ** |
