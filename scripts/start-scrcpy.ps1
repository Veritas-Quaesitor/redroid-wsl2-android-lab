param(
    [string]$Device = "127.0.0.1:5555",
    [string]$ScrcpyPath = "$env:USERPROFILE\software\scrcpy-win64-v3.3.4\scrcpy.exe"
)

if (-not (Test-Path $ScrcpyPath)) {
    Write-Error "scrcpy.exe not found at: $ScrcpyPath"
    Write-Host "Download scrcpy from: https://github.com/Genymobile/scrcpy/releases"
    exit 1
}

Write-Host "[INFO] Starting scrcpy for $Device..."
& $ScrcpyPath -s $Device --no-audio