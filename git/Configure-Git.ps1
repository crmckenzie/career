$existingConfig = Join-Path $env:UserProfile .gitconfig 
if (Test-Path $existingConfig) {
    mv $existingConfig "$existingConfig.bak"

}

New-Item -ItemType SymbolicLink -Path $env:UserProfile -Name .gitconfig -Target "$(pwd)\.gitconfig"

