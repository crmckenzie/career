$documents = "$home\Documents"
$powershellDir = "$documents\WindowsPowershell"
$moduleDir = "$powershellDir\Modules"


set-alias np "C:\Program Files (x86)\Notepad++\Notepad++.exe"
set-alias x explorer
set-alias which where.exe
set-alias vim 'C:\git\bin\vim\vim.exe'

if (Get-Module -ListAvailable posh-git) {
    import-module posh-git
}

write-host "Powershell Initialized. Ready... Set... GO!!!" -ForegroundColor Green
