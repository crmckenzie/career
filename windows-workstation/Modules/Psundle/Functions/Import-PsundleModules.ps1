function Import-PsundleModules(){
  Get-PsundleModules | Import-Module -Global
}
