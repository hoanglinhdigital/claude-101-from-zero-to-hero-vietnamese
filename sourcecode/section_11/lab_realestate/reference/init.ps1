# init.ps1 — kiểm tra nhanh "dự án còn khoẻ không" trước khi bắt đầu một phiên làm việc mới.
# Chạy: powershell -NoProfile -ExecutionPolicy Bypass -File init.ps1
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ok = $true

Write-Host "0/3 Bật database (docker compose)..."
docker compose up -d db | Out-Null
if ($LASTEXITCODE -ne 0) { $ok = $false; Write-Host "  -> FAIL: không bật được container db (Docker Desktop đã chạy chưa?)" }

Write-Host "1/3 Typecheck..."
npx tsc --noEmit
if ($LASTEXITCODE -ne 0) { $ok = $false; Write-Host "  -> FAIL typecheck" }

Write-Host "2/3 Kiểm tra kiến trúc..."
node scripts/check-architecture.mjs
if ($LASTEXITCODE -ne 0) { $ok = $false; Write-Host "  -> FAIL kiến trúc" }

Write-Host "3/3 Test..."
npx vitest run --passWithNoTests
if ($LASTEXITCODE -ne 0) { $ok = $false; Write-Host "  -> FAIL test" }

if ($ok) { Write-Host "INIT OK: dự án ở trạng thái sạch, có thể bắt đầu feature mới."; exit 0 }
Write-Host "INIT FAIL: sửa lỗi nền trước khi làm feature mới."
exit 1
