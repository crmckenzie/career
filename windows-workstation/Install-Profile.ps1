$home = $env:Home
$documents = "$home\Documents"
$powershellDir = "$home\Documents\WindowsPowershell"

Copy-item "$PSScriptRoot\Profile.ps1" $powershellDir