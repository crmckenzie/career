# Show File Extensions
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key ShowSuperHidden 0
Stop-Process -processname explorer

if (test-path alias:\curl) {
	write-host "Powershell is being a bad citizen by aliasing 'curl'. Removing the alias.'
	remove-item alias:\curl
}
