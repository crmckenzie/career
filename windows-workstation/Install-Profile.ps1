(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex

$documents = "$home\Documents"
$powershellDir = "$documents\WindowsPowershell"
$moduleDir = "$powershellDir\Modules"


$isgModuleDir = "$moduleDir\Isg"
write-host "Installing ISG"
git clone https://github.com/crmckenzie/Isg-Powershell-Module.git $isgModuleDir
write-host "ISG Installed."

write-host "Installing Posh-Git"
Install-Module Posh-Git
write-host "Posh-Git installed."

write-host "Installing PSCX"
curl "http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pscx&DownloadId=923562&FileTime=130585918034470000&Build=21028" -OutFile pscx.msi
msiexec /i pscx.msi /q
remove-item pscx.msi -force
write-host "PSCX Installed"

Copy-item "$PSScriptRoot\Profile.ps1" $powershellDir
