# Overview
Suite of powershell scripts to setup and configure a development workstation. All commands should be run in a powershell session.

# Requirements
* Powershell

1. Set-ExecutionPolicy Unrestricted
2. Install chocolatey
``iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))``

3. choco install tortoisegit
4. add git to the path

``$path = $env:path + ";C:\Program Files (x86)\Git\bin"
[Environment]::SetEnvironmentVariable("Path", $path, [System.EnvironmentVariableTarget]::Machine)``

5. git clone https://github.com/Parametric/dev_machine_setup.git C:\path\to\your\source\code
6. Configure-Machine.ps1
7. Upgrade-Powershell
8. Reboot
9. Install-Profile
10. Install-ChocolatelyPackages - you should "opt in" to the the packages you want by commenting packages in/out