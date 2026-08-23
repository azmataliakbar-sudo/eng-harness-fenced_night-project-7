$queue = "attack-queue.txt"
$log = "log.txt"

if (Test-Path $log) { Remove-Item $log }
Add-Content -Path $log -Value "# Fenced Night Log"

$items = Get-Content $queue | Where-Object { $_ -match '\S' -and $_ -notmatch '^\s*#' }

foreach ($item in $items) {
    # Strip the label prefix (safe:/malicious:)
    $text = $item -replace '^(safe|malicious):\s*', ''

    $verdict = & ".\fence.ps1" -Item $text

    Write-Host "Item: $text" -ForegroundColor Cyan
    if ($verdict -eq "allowed") {
        Write-Host "  -> ALLOWED" -ForegroundColor Green
    } else {
        Write-Host "  -> BLOCKED ($verdict)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "===== Morning Log =====" -ForegroundColor DarkCyan
Get-Content $log
