# BoxStarter script
#START http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/crmckenzie/career/master/windows-workstation/box-starter.ps1

Set-ExplorerOptions -showHiddenFilesFoldersDrives -showProtectedOSFiles -showFileExtensions
Enable-RemoteDesktop
Disable-UAC
Move-LibraryDirectory "Personal" "$env:UserProfile\OneDrive\documents"

cinst 7zip
cinst chrome
cinst conemu
cinst dotnetcore-sdk
cinst fiddler4
cinst git
cinst gitkraken
cinst linqpad4
cinst nodejs.install
cinst notepadplusplus
cinst nuget.commandline
cinst nugetpackageexplorer
cinst origin
cinst poshgit
cinst rapidee
cinst resharper
cinst steam
cinst sysinternals
cinst tortoisegit
cinst visualstudiocode
cinst windirstat
cinst zoomit

# Reboot so that PATH changes take effect
if (Test-PendingReboot) { Invoke-Reboot }

write-host "Setting up development directory." -ForegroundColor Green
mkdir "$($env:Home)\src"
pushd "$($env:Home)\src"

write-host "Setting up git config." -ForegroundColor Green
git clone http://github.com/crmckenzie/career
$existingConfig = Join-Path $env:UserProfile .gitconfig 
if (Test-Path $existingConfig) {
    mv $existingConfig "$existingConfig.bak"
}
New-Item -ItemType SymbolicLink -Path $env:UserProfile -Name .gitconfig -Target (Resolve-Path "windows-workstation\.gitconfig")


write-host "Installing default powershell profile." -ForegroundColor Green
. ./windows-workstation/Install-Profile.ps1
popd

write-host "Installing grunt and gulp." -ForegroundColor Green
npm install -g grunt-cli
npm install -g gulp-cli

#cinst Microsoft-Hyper-V-All -source windowsFeatures
#cinst IIS-WebServerRole -source windowsfeatures
#Install-WindowsUpdate -AcceptEula

write-host "You will need to install Visual Studio 2017 and Sql Server 2016 separately."
