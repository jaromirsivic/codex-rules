$null = [Console]::In.ReadToEnd()
$logPath = Join-Path $PSScriptRoot 'prompt-submission.log'
$timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
Add-Content -LiteralPath $logPath -Value "$timestamp UserPromptSubmit received"
