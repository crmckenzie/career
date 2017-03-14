# BoxStarter script
#START http://boxstarter.org/package/nr/url?<raw url>

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

if (Test-PendingReboot) { Invoke-Reboot }

mkdir "$($env:Home)\src"
pushd "$($env:Home)\src"

write-host "Setting up git config"
git clone http://github.com/crmckenzie/career
$existingConfig = Join-Path $env:UserProfile .gitconfig 
if (Test-Path $existingConfig) {
    mv $existingConfig "$existingConfig.bak"
}
New-Item -ItemType SymbolicLink -Path $env:UserProfile -Name .gitconfig -Target (Resolve-Path "windows-workstation\.gitconfig")


# Install default powershell profile
. ./windows-workstation/Install-Profile.ps1

popd


#cinst Microsoft-Hyper-V-All -source windowsFeatures
#cinst IIS-WebServerRole -source windowsfeatures
#Install-WindowsUpdate -AcceptEula

write-host "You will need to install Visual Studio 2017 and Sql Server 2016 separately."
