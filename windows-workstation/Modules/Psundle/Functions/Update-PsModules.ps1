function Update-PsModules {
  $psundleModulesDirectory = Get-PsundleModulesDirectory

  write-debug "PsundleModulesDirectory: $PsundleModulesDirectory"

  $owners = (gci $psundleModulesDirectory)
  $owners | foreach {

    $ownerPath = Join-Path $PsundleModulesDirectory $_

    write-debug "Updating modules from $ownerPath"

    $modules = (gci $ownerPath)
    $modules | foreach {
      $modulePath = Join-Path $ownerPath $_

      write-debug "Updating PsModule $modulePath"

      pushd $modulePath
      git pull origin master
      popd
    }
  }

}
