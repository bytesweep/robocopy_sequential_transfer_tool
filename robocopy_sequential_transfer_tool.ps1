<#
.SYNOPSIS
    Sequential Robocopy Batch Transfer Script with Individual Logging and Exclusions.

.DESCRIPTION
    This script automates multiple Robocopy jobs, creating a unique log for each.
    It includes exclusion logic to prevent copying system folders like the Recycle Bin.
    Filenames are timestamped to the second to prevent overwriting.

.NOTES
    Date: 2026-01-06
#>

# 1. Setup Environment
$ScriptStartTime = Get-Date -Format "yyyyMMdd_HHmm"
$LogFolder = Join-Path "$env:USERPROFILE\Desktop" "RoboLogs_$ScriptStartTime"

if (!(Test-Path $LogFolder)) { 
    New-Item $LogFolder -ItemType Directory | Out-Null 
}

# 2. Shared Parameters & Exclusions
# /XD : Excludes specific directories (prevents Recycle Bin carry-over)
$ExcludeFolders = @('"$RECYCLE.BIN"', '"System Volume Information"')

$RoboArgs = @("/E", "/R:3", "/W:5", "/Z", "/J", "/V", "/TEE", "/XD") + $ExcludeFolders

# 3. List of Transfer Jobs
# Replace these with your actual Source and Destination paths
$Jobs = @(
    @{ Src = "C:\Path\To\Source1"; Dst = "D:\Path\To\Destination1" }
    @{ Src = "C:\Path\To\Source2"; Dst = "D:\Path\To\Destination2" }
    @{ Src = "C:\Path\To\Source3"; Dst = "D:\Path\To\Destination3" }
)

Write-Host "--- BATCH START: $ScriptStartTime ---" -ForegroundColor Yellow
Write-Host "Excluding: $ExcludeFolders" -ForegroundColor Gray

# 4. Execution Loop
foreach ($Job in $Jobs) {
    # Unique timestamp for filename: robocopy_20260106_171501.txt
    $JobTimeStamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $LogName = "robocopy_$($JobTimeStamp).txt"
    $FullLogPath = Join-Path $LogFolder $LogName

    Write-Host "Transferring: $($Job.Src)" -ForegroundColor Cyan
    
    # Run Robocopy with the dynamic log path
    # Variables are wrapped in $() to handle folder paths with spaces
    robocopy $($Job.Src) $($Job.Dst) $RoboArgs /LOG:$FullLogPath
    
    Write-Host "Finished. Log: $LogName" -ForegroundColor Green
    Write-Host "--------------------------------------------"
}

Write-Host "ALL JOBS COMPLETE. Logs in: $LogFolder" -ForegroundColor Magenta