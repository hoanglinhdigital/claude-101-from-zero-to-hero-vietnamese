# PostToolUse sensor: sau mỗi lần Edit/Write file .ts/.tsx chạy eslint + typecheck + kiểm tra kiến trúc.
# exit 2 + stderr  => Claude Code đưa nội dung lỗi ngược lại cho model để tự sửa.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$stdinJson = [Console]::In.ReadToEnd()
try { $hookData = $stdinJson | ConvertFrom-Json } catch { exit 0 }

$filePath = $hookData.tool_input.file_path
if ([string]::IsNullOrWhiteSpace($filePath)) { exit 0 }

$ext = [System.IO.Path]::GetExtension($filePath)
if (@('.ts', '.tsx') -notcontains $ext) { exit 0 }

$errors = @()

$lint = npx eslint "$filePath" 2>&1 | Out-String
if ($LASTEXITCODE -ne 0) { $errors += "[ESLINT]`n$lint" }

$tsc = npx tsc --noEmit 2>&1 | Out-String
if ($LASTEXITCODE -ne 0) { $errors += "[TYPECHECK]`n$tsc" }

if (Test-Path scripts/check-architecture.mjs) {
    $arch = node scripts/check-architecture.mjs 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) { $errors += "[ARCHITECTURE]`n$arch" }
}

if ($errors.Count -gt 0) {
    $message = "Harness sensor phát hiện lỗi sau khi sửa $filePath. Hãy sửa ngay rồi mới làm tiếp:`n" + ($errors -join "`n")
    if ($message.Length -gt 4000) { $message = $message.Substring(0, 4000) + "`n... (đã cắt bớt)" }
    [Console]::Error.WriteLine($message)
    exit 2
}
exit 0
