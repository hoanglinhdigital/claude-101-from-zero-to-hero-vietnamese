# Stop sensor: trước khi Claude kết thúc lượt, chạy kiểm tra kiến trúc + test.
# Fail -> exit 2 + stderr: Claude không được dừng, phải sửa tiếp.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$stdinJson = [Console]::In.ReadToEnd()
try { $hookData = $stdinJson | ConvertFrom-Json } catch { exit 0 }

# Chống vòng lặp vô hạn: nếu Claude đang tiếp tục do chính Stop hook trước đó, không chặn nữa.
if ($hookData.stop_hook_active -eq $true) { exit 0 }

$errors = @()

if (Test-Path scripts/check-architecture.mjs) {
    $arch = node scripts/check-architecture.mjs 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) { $errors += "[ARCHITECTURE]`n$arch" }
}

$tests = npx vitest run --passWithNoTests 2>&1 | Out-String
if ($LASTEXITCODE -ne 0) { $errors += "[TEST]`n$tests" }

if ($errors.Count -gt 0) {
    $message = "Chưa được kết thúc. Hãy sửa code (không sửa/xoá test để lách) rồi chạy lại:`n" + ($errors -join "`n")
    if ($message.Length -gt 4000) { $message = $message.Substring(0, 4000) + "`n... (đã cắt bớt)" }
    [Console]::Error.WriteLine($message)
    exit 2
}
exit 0
