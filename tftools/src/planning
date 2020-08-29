function Invoke-TerraformPlan {
    $tempPlan = [System.IO.Path]::GetTempFileName()
    $tf = terraform plan -out="$tempPlan"
    terraform show -json "$tempPlan" | ConvertFrom-Json | Select-Object -ExpandProperty "resource_changes"
    Remove-Item $tempPlan
}