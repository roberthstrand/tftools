function Get-TerraformVersion {
    param (
        [switch]
        $SilentlyRun
    )
    if (!$SilentlyRun) {
        Write-tftoolsLogo
        Write-Host "Versions of Terraform, switch active version by using Set-TerraformVersion"
    }
    # Get the library path and get the currently available versions
    Set-PlatformVariables
    $versionsAvailable = (Get-ChildItem $tfPath -Directory).Name
    
    # Find out what the current version of Terraform is, or give a warning of there are none
    try {
        $activeVersion = ((terraform --version | select-string -Pattern "([\d]+.[\d]+.[\d]+-[\w]+[\d]+|[\d]+.[\d]+.[\d]+)").Matches.Value | Select-Object -First 1)
    }
    catch {
        Write-Warning "There are no versions of Terraform currently active."
    }
    $results = New-Object -TypeName System.Collections.ArrayList
    $results.Clear()

    $versionsAvailable | ForEach-Object {
        if ($_ -match "($activeVersion\b)") {
            $results.add("> $_") | Out-Null
        } else {
            $results.add("  $_") | Out-Null
        }
    }
    return $results
}
function Set-TerraformVersion {
    param (
        # Terraform version
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Version
    )
    Set-PlatformVariables
    try {
        Write-Host "Switching to Terraform v$Version" -ForegroundColor Magenta
        # Copy the terraform file to the WindowsApps directory on Windows, so you're able to execute it
        # On linux, we copy the file to the library folder and add that to $Env:PATH through our $PROFILE
        # TODO: Check whether the Unix flow will be the right one for all platforms, so that we can have one less switch, maybe...
        switch ($machineOS) {
            "windows_amd64" {
                Copy-Item -Path "$tfPath/$Version/terraform.exe" -Destination $execDir -Force -ErrorAction Stop
            }
            Default {
                Copy-Item -Path "$tfPath/$Version/terraform" -Destination $tfPath -Force -ErrorAction Stop
                chmod +x "$tfPath/terraform"
            }
        }
    }
    catch {
        Write-Error "Version of Terraform not present in library"
        Write-Host "Download Terraform v$Version ?"
        do {
            $userResponse = Read-Host "(Y)es, (N)o"
        } until ($userResponse -eq "y" -or "n")
        switch ($userResponse.ToLower()) {
            y {
                Install-Terraform -Version $Version -DisableLogo
            }
            n {
                Write-Host "Not downloading v$Version" -ForegroundColor Red
                break
            }
        }
        $activeVersion = (terraform --version | select-string -Pattern "([0-9]+\.[0-9]+\.[0-9]+)").Matches.Value | Select-Object -First 1
        if ($activeVersion -eq $Version) {
            Write-Host "Verification: Version downloaded and is currently active" -ForegroundColor DarkYellow
        }
    }
}