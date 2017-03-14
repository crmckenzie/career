$documents = [Environment]::GetFolderPath("MyDocuments")
$powershellDir = "$documents\WindowsPowershell"
$moduleDir = "$powershellDir\Modules"


$files = [System.IO.Directory]::GetFiles("$PSSCriptRoot\Profiles")
$files | foreach {
    $file = New-Object "System.IO.FileInfo" $_

    $symlink = "$powershellDir\$($file.Name)"
    if ([System.IO.FIle]::Exists($symlink)){
        write-debug "Removing old symlink for $symlink"
        [System.IO.File]::Delete($symlink)
    }

    if (-not (Test-Path $powershellDir)) {
        write-host "Creating the powershell directory at $powershellDir."
        New-Item -ItemType Directory -Path $powershellDir -Force
    }

    write-host "Creating symbolic link $powershellDir\$($file.Name) => $($file.FullName)."
    New-Item -ItemType SymbolicLink -Path $powershellDir -Name $file.Name -Value $file.FullName
}
