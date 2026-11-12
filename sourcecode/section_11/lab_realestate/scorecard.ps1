# scorecard.ps1 — "thước đo" kết quả của agent (dành cho con người, KHÔNG phải một phần của harness).
# Chạy: powershell -NoProfile -ExecutionPolicy Bypass -File scorecard.ps1 -Label v0-weak
# Mỗi lần chạy in một bảng và ghi thêm một dòng vào scoreboard.csv để so sánh giữa các giai đoạn.
param([Parameter(Mandatory = $true)][string]$Label)
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

function PassFail($code) { if ($code -eq 0) { 'PASS' } else { 'FAIL' } }

$row = [ordered]@{ timestamp = (Get-Date -Format s); label = $Label }

npx tsc --noEmit *> $null
$row.typecheck = PassFail $LASTEXITCODE

npm run lint --silent *> $null
$row.lint = PassFail $LASTEXITCODE

$testFiles = @(Get-ChildItem src -Recurse -File -Include *.test.ts, *.test.tsx -ErrorAction SilentlyContinue)
$row.test_files = $testFiles.Count
if ($testFiles.Count -gt 0) {
    npx vitest run *> $null
    $row.tests = PassFail $LASTEXITCODE
} else {
    $row.tests = 'NONE'
}

# Số file UI (src/app, src/components) import trực tiếp Prisma (không tính "import type")
$pattern = "@prisma/client|@/lib/prisma|@/lib/db|lib/(prisma|db)['""]"
$uiFiles = @(Get-ChildItem src/app, src/components -Recurse -File -Include *.ts, *.tsx -ErrorAction SilentlyContinue)
$row.ui_db_imports = @($uiFiles | Where-Object {
        $hits = Select-String -Path $_.FullName -Pattern $pattern | Where-Object { $_.Line -notmatch '^\s*import\s+type\b' }
        $hits.Count -gt 0
    }).Count

# Số chỗ dùng "any" trong TypeScript
$srcFiles = @(Get-ChildItem src -Recurse -File -Include *.ts, *.tsx -ErrorAction SilentlyContinue)
$row.any_usage = @($srcFiles | Select-String -Pattern ':\s*any\b|as any\b|<any>').Count

[pscustomobject]$row | Format-List

$csv = 'scoreboard.csv'
[pscustomobject]$row | Export-Csv -Path $csv -Append -NoTypeInformation -Encoding utf8
Write-Host "Đã ghi vào $csv"
