# tftools documentation

More specific documentation coming soon, but the following cmdlets are available:

```powershell
# Checks for available versions of Terraform, highlights the one currently in use
Get-TerraformVersion
# Set the version of Terraform that you want, can run Install-Terraform if the version is not on your local machine
Set-TerraformVersion
# Fetches either a specific version of Terraform, or the latest one if you need that
Install-Terraform
# Removes a specific version of Terraform
Remove-Terraform
```