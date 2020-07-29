# ---- Dot sourcing the code ----- #
. $PSScriptRoot\src\helpers.ps1
. $PSScriptRoot\src\installation.ps1
. $PSScriptRoot\src\versionhandling.ps1

New-Alias -Name itf -Value "Install-Terraform"
New-Alias -Name rtf -Value "Remove-Terraform"
New-Alias -Name gtfv -Value "Get-TerraformVersion"
New-Alias -Name stfv -Value "Set-TerraformVersion"