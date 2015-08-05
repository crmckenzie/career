function Install-PsModule($owner, $moduleName) {
  $PsundleModuleDirectory = Get-PsundleModulesDirectory

  $moduleDir = "$PsundleModuleDirectory/$owner/$moduleName"

  if ([System.IO.Directory]::Exists($moduleDir)) {
    write-debug "Psundle: $owner/$moduleName is already installed. Skipping."
  }
  else
  {
    $cmd = "git clone http://github.com/$owner/$modulename.git $moduleDir"
    $cmd
    Invoke-Expression $cmd
  }


  $moduleDefinitions = (gci $moduleDir *.psm1)
  if ($moduleDefinitions.Count -eq 0) {
    throw "Could not find any module definitions in $moduleDir. This repository does not appear to be a powershell module."
    return -1
  }

  $moduleDefinition = $moduleDefinitions[0].FullName

  $cmd = "Import-Module '$moduleDefinition'"
  $cmd
  Invoke-expression $cmd
}
