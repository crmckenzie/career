choco install powershell
$answer = read-host "Upgrading powershell requires a reboot. Would you like to restart now? (y/n)"
Restart-Computer -Confirm