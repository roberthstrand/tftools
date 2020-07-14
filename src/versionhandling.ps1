function Get-TerraformVersion {
    Write-tftoolsLogo
    Write-Host "Versions of Terraform, switch active version by using Set-TerraformVersion"
    
    # Get the library path and get the currently available versions
    Set-tftoolsPath
    $versionsAvailable = (Get-ChildItem $tfPath).Name
    
    # Find out what the current version of Terraform is, or give a warning of there are none
    try {
        $activeVersion = ((terraform --version | select-string -Pattern "([0-9]+\.[0-9]+\.[0-9]+)").Matches.Value | Select-Object -First 1).Substring(1)
    }
    catch {
        Write-Warning "There are no versions of Terraform currently active."
    }
    $versionsAvailable | ForEach-Object {
        if ($_ -match "($activeVersion\b)") {
            Write-host "* $_" -ForegroundColor Green
        }
        else {
            Write-host "  $_"
        }
    }
}
function Set-TerraformVersion {
    param (
        # Terraform version
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Version
    )
    switch ($psversiontable) {
        (($psversiontable.PSVersion.Major -le 5) -or ($psversiontable.Platform -eq "Win32NT")) { $tfPath = $env:USERPROFILE + "\.tftools" }
        default { $tfPath = $home + "/.tftools" }
    }
    try {
        Write-Host "Switching to Terraform v$Version" -ForegroundColor Magenta
        Copy-Item -Path "$tfPath/$Version/terraform*" -Destination "$env:LOCALAPPDATA\Microsoft\WindowsApps" -Force -ErrorAction Stop
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