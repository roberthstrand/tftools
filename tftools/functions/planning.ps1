function Invoke-TerraformPlan {
    <#
    .SYNOPSIS
    A wrapper for terraform plan, making it easier to...
    .DESCRIPTION
    .PARAMETER Path
    The path from where you want to execute the terraform plan
    .PARAMETER OutputFile
    Set the filename used to save the generated plan to a file for later execution.
    .INPUTS
    None
    .OUTPUTS
    Resource objects
    .EXAMPLE
    Invoke-TerraformPlan
    .EXAMPLE
    Invoke-TerraformPlan -OutputFile "great.plan"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 1)]
        [string]
        $Path,
        [Parameter(Position = 2)]
        [string]
        $OutputFile,
        [Parameter(Position = 3)]
        [switch]
        $Init
    )
    begin {
        Write-Verbose -Message "Running..."
        # Setting variables
        if (!$OutputFile) {
            Write-Verbose -Message "No output file is defined, creating a temporary file."
            $tempPlan = [System.IO.Path]::GetTempFileName()
        }

        # Initializing
        if ($Init) {
            Write-Verbose -Message "Initialize the workfolder."
            Write-Information -MessageData "Running: terraform init" -InformationAction Continue
            terraform init | Out-Null
        }
    }

    process {
        # Invoke the plan, write it to a temporary file
        terraform plan -out="$tempPlan" $Path | Out-Null
        
        if ($LASTEXITCODE -eq 1) {
            Write-Verbose -Message "Exit code 1 triggered, stopping the script."
            break
        }
        Write-Information -MessageData "Running: terraform plan"
        $result = terraform show -json "$tempPlan" | ConvertFrom-Json | Select-Object -ExpandProperty "resource_changes"
        Write-Verbose -Message "Terraform plan successfully ran."

        $result | ForEach-Object {
            [PSCustomObject]@{
                Type            = $_.type
                Name            = $_.change.after.name
                location        = $_.change.after.location
                ResourceGroup   = $_.change.after.resource_group_name
                Address         = $_.address
                Details         = $_.change.after
            }
        }
    }

    end {
        # Cleaning up
        if (!$OutputFile) {
            Write-Verbose -Message "Cleaning up the temporary file"
            Remove-Item $tempPlan
        }
    }
}