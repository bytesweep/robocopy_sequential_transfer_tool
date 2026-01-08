# Robocopy Sequential Transfer Tool

A PowerShell script that automates multiple Robocopy file transfers with individual logging and smart exclusions.

## Features

- **Sequential Transfers**: Processes multiple source/destination pairs one at a time
- **Individual Logging**: Creates a unique timestamped log file for each transfer job
- **System Folder Exclusions**: Automatically excludes `$RECYCLE.BIN` and `System Volume Information`
- **Robust Copy Options**: Uses `/E`, `/Z`, `/J` flags for reliable transfers with resume capability
- **Organized Logs**: All logs saved to a timestamped folder on your desktop

## Requirements

- Windows OS
- PowerShell 5.0 or higher
- Administrator privileges (recommended for full access)

## Usage

1. Open the script in a text editor
2. Modify the `$Jobs` array (lines 30-34) with your source and destination paths:

```powershell
$Jobs = @(
    @{ Src = "C:\Your\Source\Folder"; Dst = "D:\Your\Destination\Folder" }
    @{ Src = "C:\Another\Source"; Dst = "E:\Another\Destination" }
)
```

3. Run the script in PowerShell:

```powershell
.\robocopy_sequential_transfer_tool.ps1
```

## Robocopy Parameters

The script uses the following Robocopy flags:

- `/E` - Copy subdirectories, including empty ones
- `/R:3` - Retry 3 times on failed copies
- `/W:5` - Wait 5 seconds between retries
- `/Z` - Copy in restartable mode (resume interrupted transfers)
- `/J` - Unbuffered I/O for large files
- `/V` - Verbose output
- `/TEE` - Output to console and log file
- `/XD` - Exclude specified directories

## Output

Logs are saved to: `%USERPROFILE%\Desktop\RoboLogs_[timestamp]\`

Each job creates a log file named: `robocopy_[timestamp].txt`

## Example Output

```
--- BATCH START: 20260106_1715 ---
Excluding: "$RECYCLE.BIN" "System Volume Information"
Transferring: C:\Path\To\Source1
Finished. Log: robocopy_20260106_171501.txt
--------------------------------------------
Transferring: C:\Path\To\Source2
Finished. Log: robocopy_20260106_171523.txt
--------------------------------------------
ALL JOBS COMPLETE. Logs in: C:\Users\...\Desktop\RoboLogs_20260106_1715
```

## License

Free to use and modify for your needs.
