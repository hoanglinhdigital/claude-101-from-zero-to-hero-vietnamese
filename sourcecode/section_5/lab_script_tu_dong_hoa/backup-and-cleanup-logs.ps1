<#
.SYNOPSIS
    Backup file log moi va don dep (xoa) file log qua cu.

.DESCRIPTION
    Script tu dong hoa tac vu van hanh lap lai:
    1. Copy toan bo file log trong -LogPath (moi hon -RetentionDays) sang mot
       thu muc con moi trong -BackupPath, dat ten theo timestamp hien tai.
    2. Sau khi backup xong, xoa cac file log trong -LogPath cu hon -RetentionDays.
    Script in ra console so file da backup / da xoa, va co kiem tra loi co ban
    (duong dan ton tai, quyen truy cap) truoc khi thao tac.

.PARAMETER LogPath
    Duong dan thu muc chua file log can backup/don dep. Bat buoc.

.PARAMETER BackupPath
    Duong dan thu muc goc de luu ban backup. Bat buoc.

.PARAMETER RetentionDays
    So ngay giu lai log. File log co thoi gian sua doi (LastWriteTime) cu hon
    so ngay nay se bi xoa khoi LogPath sau khi da duoc backup. Mac dinh: 30.

.EXAMPLE
    .\backup-and-cleanup-logs.ps1 -LogPath "D:\App\logs" -BackupPath "D:\App\log-backups"

.EXAMPLE
    .\backup-and-cleanup-logs.ps1 -LogPath "D:\App\logs" -BackupPath "E:\backups\app-logs" -RetentionDays 14
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$LogPath,

    [Parameter(Mandatory = $true)]
    [string]$BackupPath,

    [Parameter(Mandatory = $false)]
    [int]$RetentionDays = 30
)

$ErrorActionPreference = "Stop"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] [$Level] $Message"
}

Write-Log "===== Bat dau backup-and-cleanup-logs ====="
Write-Log "LogPath        : $LogPath"
Write-Log "BackupPath     : $BackupPath"
Write-Log "RetentionDays  : $RetentionDays"

# ── Kiem tra path dau vao ──────────────────────────────────────────────
if (-not (Test-Path -Path $LogPath -PathType Container)) {
    Write-Log "LogPath khong ton tai hoac khong phai la thu muc: $LogPath" "ERROR"
    exit 1
}

if (-not (Test-Path -Path $BackupPath -PathType Container)) {
    Write-Log "BackupPath chua ton tai, dang tao moi: $BackupPath" "WARN"
    try {
        New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    }
    catch {
        Write-Log "Khong the tao BackupPath: $($_.Exception.Message)" "ERROR"
        exit 1
    }
}

$cutoffDate = (Get-Date).AddDays(-$RetentionDays)
Write-Log "Cutoff date (log cu hon moc nay se bi xoa sau khi backup): $cutoffDate"

# ── Buoc 1: Backup toan bo file log hien co sang thu muc con theo timestamp ──
$timestampFolder = Get-Date -Format "yyyyMMdd_HHmmss"
$destinationFolder = Join-Path -Path $BackupPath -ChildPath $timestampFolder

$logFiles = Get-ChildItem -Path $LogPath -File -Recurse -ErrorAction SilentlyContinue

if ($null -eq $logFiles -or $logFiles.Count -eq 0) {
    Write-Log "Khong tim thay file log nao trong $LogPath — bo qua buoc backup." "WARN"
}
else {
    try {
        New-Item -ItemType Directory -Path $destinationFolder -Force | Out-Null
    }
    catch {
        Write-Log "Khong the tao thu muc backup $destinationFolder : $($_.Exception.Message)" "ERROR"
        exit 1
    }

    $backupCount = 0
    foreach ($file in $logFiles) {
        try {
            Copy-Item -Path $file.FullName -Destination $destinationFolder -Force
            $backupCount++
        }
        catch {
            Write-Log "Loi khi copy file $($file.FullName): $($_.Exception.Message)" "ERROR"
        }
    }
    Write-Log "Da backup $backupCount file log vao: $destinationFolder"
}

# ── Buoc 2: Xoa file log cu hon RetentionDays trong LogPath ─────────────
$oldLogFiles = Get-ChildItem -Path $LogPath -File -Recurse -ErrorAction SilentlyContinue |
    Where-Object { $_.LastWriteTime -lt $cutoffDate }

if ($null -eq $oldLogFiles -or $oldLogFiles.Count -eq 0) {
    Write-Log "Khong co file log nao cu hon $RetentionDays ngay — khong can xoa."
}
else {
    $deleteCount = 0
    foreach ($file in $oldLogFiles) {
        try {
            Remove-Item -Path $file.FullName -Force
            $deleteCount++
            Write-Log "Da xoa: $($file.FullName) (LastWriteTime: $($file.LastWriteTime))"
        }
        catch {
            Write-Log "Loi khi xoa file $($file.FullName): $($_.Exception.Message)" "ERROR"
        }
    }
    Write-Log "Tong so file log da xoa: $deleteCount"
}

Write-Log "===== Hoan thanh backup-and-cleanup-logs ====="
