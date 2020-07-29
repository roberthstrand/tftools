# ---- Installation of Terraform ---- #
function Install-Terraform {
    [CmdletBinding()]
    param (
        # Version of Terraform to install
        [Parameter(Position = 0)]
        [string]
        $Version,
        # Disable logo, if called by another cmdlet
        [Parameter()]
        [switch]
        $DisableLogo,
        # Automatically set the downloaded version as the active one
        [Parameter()]
        [switch]
        $SetAsActive
    )
    <#----------------------------------------------+
    |The secret to getting ahead is getting started |
    |                 - Mark Twain                  |
    +----------------------------------------------#>
    begin {
        # Write the logo, +1 to sexiness - if not disabled
        if (!$DisableLogo) { Write-tftoolsLogo }
        # Set platform specific variables, by determining what version of PowerShell is running and on what platform
        Set-PlatformVariables
        # Check if the working directory exists, create it if it doesn't
        try { 
            New-Item -Path $tfPath -ItemType Directory -ErrorAction Stop | Out-Null
        }
        catch { 
            Write-Host "Working directory found..." -ForegroundColor Green
        }
        # If the version parameter wasn't used, ask the user what version they want installed
        # Can also be set to latest, or TODO:beta-latest 
        if (!$Version) {
            Write-Host "What version do you want?"
            do {
                $userResponse = Read-Host "Version number or (l)atest`n"
                $Version = $userResponse
            } while ($userResponse.ToLower() -notmatch "(latest)|(l\b)|(beta-latest)|(b\b)|([0-9]+\.[0-9]+\.[0-9]+)?(-[\S]+)?()")
        }
        elseif ($Version -eq "latest") {
            Write-Host "Fetching the latest version of Terraform" -ForegroundColor Yellow
        }
        elseif ($Version -eq "beta-latest") {
            Write-Host "Fetching the latest beta version of Terraform" -ForegroundColor Yellow
        }
        elseif ($Version -like "*.*.*") {
            Write-Host "Fetching Terraform v$Version" -ForegroundColor Yellow
        }
        # To avoid existential crisis, we want to check that the version asked for is available.
        # Also, if latest or beta-latest is requested, we need to figure out what that is.

        # Fetch the HashiCorp Terraform release page and stick it into an object
        $releasePageURL = "https://releases.hashicorp.com/terraform/"
        [string]$tfReleases = Invoke-WebRequest $releasePageURL -UseBasicParsing | Select-Object -ExpandProperty Content
        # We then want to pick out all the releases available
        [System.Collections.ArrayList]$tfReleases = $tfReleases -split "`n" | Select-String -Pattern '(?<=\/)([\d]+.[\d]+.[\d]+-[\w]+[\d]+|[\d]+.[\d]+.[\d]+)' |
        ForEach-Object { $_.Matches | ForEach-Object { $_.Groups[1].Value } }
        # If version is set to latest, we download the latest release if it doesn't already exist in our working path
        if (($Version -eq "latest") -or ($Version -eq "l")) {
            # We want the latest stable version, so if the latest version is beta, release candidate or simular, we'll try and find the last numbered release.
            switch ($tfReleases[0] -match '-') {
                $true { 
                    $i = 0
                    do {
                        $i += 1
                        $Version = $tfReleases[$i]
                    } while ($Version -match '-')
                }
                Default { $Version = $tfReleases[0] }
            }
        }
        elseif ($tfReleases -notcontains $Version) {
            # Stops everything if the version requested doesn't exist
            Write-Error "Invalid version"
            break
        }
    }
    process {
        # If the release exist, check wether or not it has already been downloaded
        switch (Test-Path -Path "$tfPath/$Version") {
            $false {
                Write-Progress "Downloading Terraform v$Version"
                Write-Host "Downloading Terraform v$Version" -ForegroundColor Yellow
            
                # Creating a temporary file to be used while downloading the release
                $tempFile = [System.IO.Path]::GetTempFileName()
                
                # Downloading the release
                $downloadSplat = @{
                    uri             = "https://releases.hashicorp.com/terraform/" + $version + "/terraform_" + $Version + "_" + $machineOS + ".zip"
                    OutFile         = $tempFile
                    UseBasicParsing = $true
                }
                Invoke-WebRequest @downloadSplat
                
                # Unzip that sucker!
                Export-ZipFile -ZipFile $tempFile -OutputFolder "$tfPath/$Version"
                
                # If the switch SetAsActive is present, automatically set the active version
                if ($SetAsActive) {
                    Set-TerraformVersion -Version $Version
                }
                else {
                    # Ask the user if they want to set the downloaded Terraform as the active version
                    $userResponse = Read-Host "You want to set v$Version as the active version? `n(Y)es or (n)o?"
                    # If they answer yes...
                    switch ($userResponse.ToLower()) {
                        y {
                            Set-TerraformVersion -Version $Version
                        }
                        Default { continue }
                    }
                }
                Write-Host "v$Version downloaded" -ForegroundColor Green
                if ($userResponse -eq "y") { Write-Host "And activated!" -ForegroundColor Magenta }
                # Cleanup on isle five
                Remove-Item -Path $tempFile
            }
            Default {
                Write-Error "v$Version already exist"
                continue
            }
        }
    }
    # Don’t adventures ever have an end? 
    # I suppose not. Someone else always has to carry on the story.
}
function Remove-Terraform {
    param (
        # Terraform version
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Version,
        [bool]
        $Confirm
    )
    Set-PlatformVariables
    $removeSplat = @{
        Path        = "$tfPath/$Version"
        Force       = $true
        recurse     = $true
        confirm     = $Confirm
    }
    try {
        Remove-Item @removeSplat -ErrorAction Stop
    }
    catch {
        Write-Error "Version not found"
    }
}