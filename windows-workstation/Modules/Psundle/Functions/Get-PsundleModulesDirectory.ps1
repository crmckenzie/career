function Get-PsundleModulesDirectory{
  $PsundleModule = Get-Module "Psundle"
  $psundleLocation = ""

<#
  $modulesPath = $env:PsModulePath.Split(';') | where {$_.Contains($home)}
  $psundleModulesPath = "$modulesPath/.psundle"
#>
  $moduleIsLoading= $PsundleModule -eq $null
  if ($moduleIsloading){
    $dirInfo = New-Object "System.IO.DirectoryInfo" $PSScriptRoot
    $psundleLocation = Join-Path $dirInfo.Parent.FullName "Psundle.psd1"
  }
  else {
    $psundleLocation =  $PsundleModule.Path
  }
  $directory = (New-Object "System.IO.FileInfo" $psundleLocation).Directory
  $psundleModules = "$directory\.PsundleModules"
  return $psundleModules
}
