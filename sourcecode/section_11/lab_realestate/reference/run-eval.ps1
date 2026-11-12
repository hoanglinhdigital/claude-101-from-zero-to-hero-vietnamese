# run-eval.ps1 — chạy bộ task ở chế độ headless, chấm điểm bằng scorecard.ps1 (ghi vào scoreboard.csv)
# Chạy: powershell -NoProfile -ExecutionPolicy Bypass -File run-eval.ps1 -Label v1
# CẢNH BÁO: script khôi phục working tree về HEAD sau mỗi task (git restore + git clean).
#           Hãy commit mọi thay đổi trước khi chạy và CHỈ chạy trên nhánh thực hành.
#           Các file bị git ignore (scoreboard.csv, .env) không bị xoá.
param([Parameter(Mandatory = $true)][string]$Label)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (git status --porcelain) {
    Write-Error "Working tree chưa sạch. Hãy commit (hoặc stash) trước khi chạy eval."
    exit 1
}

$tasks = Get-Content eval-tasks.json -Raw -Encoding UTF8 | ConvertFrom-Json

foreach ($task in $tasks) {
    Write-Host ">>> Task $($task.id)"
    claude -p $task.prompt --permission-mode acceptEdits --max-turns 40 | Out-Null
    powershell -NoProfile -ExecutionPolicy Bypass -File scorecard.ps1 -Label "$Label-$($task.id)"
    git restore --source=HEAD --staged --worktree .
    git clean -fd | Out-Null
}

Write-Host "`nKết quả của nhãn ${Label}:"
Import-Csv scoreboard.csv | Where-Object { $_.label -like "$Label-*" } | Format-Table label, typecheck, lint, tests, test_files, ui_db_imports, any_usage
