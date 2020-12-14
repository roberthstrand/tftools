# ---- Dot sourcing the code ----- #
$functionTypes = @(
    '/'
)

foreach ($function in $functionTypes) {
    Get-ChildItem -Name "*.ps1" -Path ($PSScriptRoot + "/functions" + $function) | ForEach-Object {
        . ($PSScriptRoot + "/functions" + $function + $_)
    }
}

New-Alias -Name itf -Value "Install-Terraform"
New-Alias -Name rtf -Value "Remove-Terraform"
New-Alias -Name gtfv -Value "Get-TerraformVersion"
New-Alias -Name stfv -Value "Set-TerraformVersion"
New-Alias -Name itp -Value "Invoke-TerraformPlan"