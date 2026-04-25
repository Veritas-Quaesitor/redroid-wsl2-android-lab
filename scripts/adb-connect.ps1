param(
    [string]$Device = "127.0.0.1:5555"
)

Write-Host "[INFO] Restarting ADB server..."
adb kill-server
adb start-server

Write-Host "[INFO] Connecting to ReDroid at $Device..."
adb connect $Device

Write-Host "[INFO] Connected devices:"
adb devices -l