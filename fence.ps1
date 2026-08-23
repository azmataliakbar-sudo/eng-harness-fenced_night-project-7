param(
    [Parameter(Mandatory=$true)]
    [string]$Item
)

$log = "log.txt"

function Log($msg) {
    Add-Content -Path $log -Value $msg
}

# Fence check 1: network (no curl / http / Invoke-WebRequest)
if ($Item -match 'curl|http://|https://|Invoke-WebRequest|Invoke-RestMethod') {
    Log "BLOCKED: network access denied for item: $Item"
    return "blocked:network"
}

# Fence check 2: gated branches (no direct push to main)
if ($Item -match 'push.*main|main.*push') {
    Log "BLOCKED: direct push to main denied for item: $Item"
    return "blocked:branch"
}

# Safe item: process it (simulate worktree + work).
Log "ALLOWED: processed safe item: $Item"
return "allowed"
