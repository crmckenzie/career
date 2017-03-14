$Documents = [Environment]::GetFolderPath("MyDocuments")
$PowershellDir = "$documents\WindowsPowershell\Modules"
$ModuleDir = "$powershellDir\Modules"


$files = [System.IO.Directory]::GetFiles("$PSSCriptRoot\Profiles")
$files | %{
    $file = $_

    $symlink = Join-Path $powershellDir $file.Name
    if (Test-Path $symlink) {
        Remove-Item $symlink -Force
    }
 
    if (-not (Test-Path $powershellDir)) {
        write-host "Creating the powershell directory at $powershellDir."
        New-Item -ItemType Directory -Path $powershellDir -Force
    }

    write-host "Creating symbolic link $powershellDir\$($file.Name) => $($file.FullName)."
    New-Item -ItemType SymbolicLink -Path $powershellDir -Name $file.Name -Value $file.FullName
}
