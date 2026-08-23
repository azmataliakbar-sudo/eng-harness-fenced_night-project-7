if (Test-Path "log.txt") { Remove-Item "log.txt" }
if (Test-Path "task-done.txt") { Remove-Item "task-done.txt" }
Get-ChildItem -Filter "SUMMARY*.md" -ErrorAction SilentlyContinue | Remove-Item
Write-Output "Reset ratchet_week."
