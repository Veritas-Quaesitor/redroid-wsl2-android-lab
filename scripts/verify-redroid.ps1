param(
    [string]$Device = "127.0.0.1:5555"
)

Write-Host "[INFO] Android version:"
adb -s $Device shell getprop ro.build.version.release

Write-Host "`n[INFO] Device model:"
adb -s $Device shell getprop ro.product.model

Write-Host "`n[INFO] Checking Google/Chrome packages:"
adb -s $Device shell pm list packages | Select-String -Pattern "chrome|gms|gsf|vending|google" -CaseSensitive:$false

Write-Host "`n[INFO] Connected devices:"
adb devices -l