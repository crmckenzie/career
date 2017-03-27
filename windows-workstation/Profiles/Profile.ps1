Set-ExecutionPolicy RemoteSigned

Get-Module -ListAvailable "posh-git" | Import-Module
if (Get-Module posh-git) {
    function global:prompt {
        $realLASTEXITCODE = $LASTEXITCODE

        Write-Host($pwd.ProviderPath) -nonewline

        Write-VcsStatus

        $global:LASTEXITCODE = $realLASTEXITCODE
        return "> "
    }

    Pop-Location

    Start-SshAgent -Quiet    
}

set-alias np "C:\Program Files (x86)\Notepad++\Notepad++.exe"
set-alias x explorer
set-alias which where.exe

remove-item alias:\curl

$My = [PsCustomObject] @{
	"Octopus" = @{
		"ApiKeys" = @{
			"Read" = "API-XD7DGUGJ8HBK9JR9WFYCOCTXVM";
			"Write" = "API-LNVERZ5FP3TM2ARHSYEF6ZLDVLQ";
		}
	}
}

# Set powershell module development path to PsModulePath
$devModulePath = "$($env:USERPROFILE)\src\Modules"
if (-not (($env:PSModulePath -split ';') -contains $devModulePath)) {
    write-host "Adding module development directory ($devModulePath) to `$env:PsModulePath."
    $CurrentValue = [Environment]::GetEnvironmentVariable("PSModulePath", "User")
    if ($CurrentValue) {
        [Environment]::SetEnvironmentVariable("PSModulePath", "$CurrentValue;$devModulePath", "User")
    } else {
        [Environment]::SetEnvironmentVariable("PSModulePath", "$devModulePath", "User")        
    }
    $env:PsModulePath += ";$devModulePath"
}

write-host "Powershell Initialized. Ready... Set... GO!!!"
