$Documents = [Environment]::GetFolderPath("MyDocuments")
$PowershellDir = "$documents\WindowsPowershell"
$ModuleDir = "$powershellDir\Modules"
$ProfilesDir = "$PSSCriptRoot\Powershell"

write-host @"
    Documents    : $Documents
    PowershellDir: $PowershellDir
    ModuleDir    : $ModuleDir
    ProfilesDir : $ProfilesDir
"@


$files = [System.IO.Directory]::GetFiles($ProfilesDir)

$files | %{
    $file = $_
    $fileName = Split-Path $file -Leaf
    $symlink = Join-Path $powershellDir $fileName
    if (Test-Path $symlink) {
        write-host "Removing existing symlink: $symlink"
        Remove-Item $symlink -Force
    }
 
    if (-not (Test-Path $powershellDir)) {
        write-host "Creating the powershell directory at $powershellDir."
        New-Item -ItemType Directory -Path $powershellDir -Force
    }

    write-host "Creating symbolic link $powershellDir\$($fileName) => $($file)."
    New-Item -ItemType SymbolicLink -Path $powershellDir -Name $fileName -Value $file
}
