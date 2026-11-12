# SessionStart hook: stdout được nạp vào context của phiên mới, giúp agent biết trạng thái dự án.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ErrorActionPreference = 'SilentlyContinue'

Write-Output "=== HARNESS: TRẠNG THÁI DỰ ÁN (tự động nạp khi bắt đầu phiên) ==="

if (Test-Path progress.md) {
    Write-Output "--- progress.md (30 dòng cuối) ---"
    Get-Content progress.md -Tail 30 -Encoding UTF8
}

Write-Output "--- 5 commit gần nhất ---"
git log --oneline -5

if (Test-Path feature_list.json) {
    $list = Get-Content feature_list.json -Raw -Encoding UTF8 | ConvertFrom-Json
    $total = @($list.features).Count
    $done = @($list.features | Where-Object { $_.passes -eq $true }).Count
    Write-Output "--- Tiến độ feature: $done/$total ---"
    $next = $list.features | Where-Object { $_.passes -ne $true } | Select-Object -First 1
    if ($next) { Write-Output "Feature tiếp theo: $($next.id) - $($next.description)" }
    else { Write-Output "Tất cả feature đã pass." }
}

Write-Output "Nhắc lại: làm theo 'Session protocol' trong CLAUDE.md."
exit 0
