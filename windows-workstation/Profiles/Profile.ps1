Set-ExecutionPolicy BypassImport-Module PSCX$documents = "$home\Documents"$powershellDir = "$documents\WindowsPowershell"$moduleDir = "$powershellDir\Modules"# load all modules in Module root(gci $moduleDir) | foreach {gci $_.FullName *.psm1} | Import-Modulewrite-host "Setup powershell environment with visual studio tools."Install-VSCommandPrompt$code = (gci 'C:\Users\ChrisMc\AppData\Local\Code\**\code.exe')[-1].FullName$atom = (gci 'C:\Users\ChrisMc\AppData\Local\atom\**\atom.exe')[-1].FullNameset-alias np "C:\Program Files (x86)\Notepad++\Notepad++.exe"set-alias x explorerset-alias which where.exeset-alias nant "C:\Program Files\Nant\bin\Nant.exe"set-alias vim 'C:\git\bin\vim\vim.exe'set-alias sqlcompare 'C:\Program Files (x86)\Red Gate\SQL Compare 11\sqlcompare.exe'set-alias code $codeset-alias atom $atomremove-item alias:\curlwrite-host "Powershell Initialized. Ready... Set... GO!!!"