param(
    [string]$Device = "127.0.0.1:5555",
    [string]$ScrcpyPath = $env:SCRCPY_PATH
)

if (-not $ScrcpyPath) {
    $Candidates = @(
        "scrcpy",
		"C:\scrcpy\scrcpy.exe",
		"$env:ProgramFiles\scrcpy\scrcpy.exe",
        "$env:USERPROFILE\scrcpy\scrcpy.exe",
        "$env:LOCALAPPDATA\Programs\scrcpy\scrcpy.exe"
    )

    foreach ($Candidate in $Candidates) {
        $Command = Get-Command $Candidate -ErrorAction SilentlyContinue
        if ($Command) {
            $ScrcpyPath = $Command.Source
            break
        }

        if (Test-Path $Candidate) {
            $ScrcpyPath = $Candidate
            break
        }
    }
}

if (-not $ScrcpyPath -or -not (Test-Path $ScrcpyPath -PathType Leaf)) {
    Write-Error @"
scrcpy.exe not found.

Options:
1. Add scrcpy.exe to PATH
2. Set SCRCPY_PATH environment variable
3. Pass -ScrcpyPath explicitly

Example:
.\scripts\start-scrcpy.ps1 -ScrcpyPath "C:\tools\scrcpy\scrcpy.exe"

Download:
https://github.com/Genymobile/scrcpy/releases
"@
    exit 1
}

Write-Host "[INFO] Starting scrcpy for $Device..."
& $ScrcpyPath -s $Device --no-audio