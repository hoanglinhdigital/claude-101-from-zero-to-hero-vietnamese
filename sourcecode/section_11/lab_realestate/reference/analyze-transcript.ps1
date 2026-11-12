# analyze-transcript.ps1 — tóm tắt một phiên Claude Code từ file transcript (.jsonl)
# Chạy trong thư mục project:  powershell -NoProfile -ExecutionPolicy Bypass -File analyze-transcript.ps1
# Hoặc chỉ định file:          ... -File analyze-transcript.ps1 -Path "C:\...\xxxx.jsonl"
param([string]$Path)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (-not $Path) {
    # Claude Code lưu transcript tại ~/.claude/projects/<đường-dẫn-project-đã-mã-hoá>/*.jsonl
    $encoded = ($PWD.Path -replace '[^A-Za-z0-9]', '-')
    $dir = Join-Path $env:USERPROFILE ".claude\projects\$encoded"
    $latest = Get-ChildItem $dir -Filter *.jsonl -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if (-not $latest) { Write-Error "Không tìm thấy transcript trong $dir"; exit 1 }
    $Path = $latest.FullName
}
Write-Host "Transcript: $Path"

$toolCount = @{}
$errorList = @()
foreach ($line in Get-Content $Path -Encoding UTF8) {
    try { $entry = $line | ConvertFrom-Json } catch { continue }
    $content = $entry.message.content
    if ($content -isnot [System.Array]) { continue }
    foreach ($item in $content) {
        if ($item.type -eq 'tool_use') {
            $toolCount[$item.name] = 1 + [int]$toolCount[$item.name]
        }
        elseif ($item.type -eq 'tool_result' -and $item.is_error -eq $true) {
            $text = if ($item.content -is [string]) { $item.content } else { ($item.content | ForEach-Object { $_.text }) -join ' ' }
            $text = ($text -replace '\s+', ' ')
            $errorList += $text.Substring(0, [Math]::Min(160, $text.Length))
        }
    }
}

Write-Host "`n=== Số lần gọi tool ==="
$toolCount.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object { "{0,-12} {1}" -f $_.Key, $_.Value }

Write-Host "`n=== Tool bị lỗi: $($errorList.Count) lần ==="
$errorList | Group-Object | Sort-Object Count -Descending | Select-Object -First 10 | ForEach-Object { "{0}x  {1}" -f $_.Count, $_.Name }

Write-Host "`nGợi ý: lỗi nào lặp lại từ 2 lần trở lên là ứng viên để thêm rule (guide) hoặc sensor mới."
