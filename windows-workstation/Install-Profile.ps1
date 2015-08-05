(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex

$documents = "$home\Documents"
$powershellDir = "$documents\WindowsPowershell"
$moduleDir = "$powershellDir\Modules"

write-host "Installing Posh-Git"
Install-Module Posh-Git
write-host "Posh-Git installed."

write-host "Installing PSCX"
Invoke-WebRequest "http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pscx&DownloadId=923562&FileTime=130585918034470000&Build=21028" -OutFile pscx.msi
msiexec /i pscx.msi /q
remove-item pscx.msi -force
write-host "PSCX Installed"

$files = [System.IO.Directory]::GetFiles("$PSSCriptRoot\Profiles")
$files | foreach {
  $file = New-Object "System.IO.FileInfo" $_
  $filename = $file.Name
  $fullFileName = $file.FullName

  $symlink = "$powershellDir\$filename"
  if ([System.IO.FIle]::Exists($symlink)){
    write-debug "Removing old symlink for $symlink"
    [System.IO.File]::Delete($symlink)
  }

  $cmd = "New-Symlink ""$symlink"" ""$fullFileName"""
  $cmd
  Invoke-Expression $cmd
}

$directories = [System.IO.Directory]::GetDirectories("$PSScriptRoot\Modules")
$directories | foreach {
  $directoryInfo = New-Object "System.IO.DirectoryInfo" $_
  $directoryName = $directoryInfo.Name
  $target = "$powershellDir\Modules\$directoryName"

  if ([System.IO.Directory]::Exists($target)) {
    $cmd = "cmd.exe /c 'rmdir $target'"
    $cmd
    Invoke-Expression $cmd
  }

  $cmd = "New-SymLink ""$target"" ""$_"""
  $cmd
  Invoke-Expression $cmd
}
