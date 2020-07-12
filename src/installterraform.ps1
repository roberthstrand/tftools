# ---- Installation of Terraform ---- #
function Install-Terraform {
    [CmdletBinding()]
    param (
        # Version of Terraform to install
        [Parameter(Position = 0)]
        [string]
        $Version
    )
    <#----------------------------------------------+
    |The secret to getting ahead is getting started |
    |                 - Mark Twain                  |
    +----------------------------------------------#>
    begin {

        # Write the logo, +1 to sexiness
        Write-tftoolsLogo

        # Figure out what version of PowerShell, and what platform the code is being ran on
        switch ($psversiontable) {
            (($psversiontable.PSVersion.Major -le 5) -or ($psversiontable.Platform -eq "Win32NT")) { $tfPath = $env:USERPROFILE + "\.tftools" }
            default {$tfPath = $home + "/.tftools"}
        }
        
        # Check if the working path exists, create it if it doesn't
        try { 
            New-Item -Path $tfPath -ItemType Directory -ErrorAction Stop | Out-Null
        } catch { 
            Write-Host "Working folder found..." -ForegroundColor Green
        }

        # If the version parameter wasn't used, ask the user what version they want installed
        # Can also be set to latest, or beta-latest
        if (!$Version) {
            Write-Host "What version do you want?"
            do {
                Write-Host "Version number, (l)atest or (b)eta-latest" -ForegroundColor Yellow
                $userResponse = Read-Host "#"
                $Version      = $userResponse
            } while ($userResponse -notmatch "(latest)|(l\b)|(beta-latest)|(b\b)|([0-9]+\.[0-9]+\.[0-9])")
        } elseif ($Version -eq "latest") {
            Write-Host "Fetching the latest version of Terraform" -ForegroundColor Green
        } elseif ($Version -eq "beta-latest") {
            Write-Host "Fetching the latest beta version of Terraform" -ForegroundColor Green
        } elseif ($Version -like "*.*.*") {
            Write-Host "Fetching Terraform v$Version" -ForegroundColor Green
        }
        # To avoid existential crisis, we want to check that the version asked for is available.
        # Also, if latest or beta-latest is requested, we need to figure out what that is.

        # Fetch the HashiCorp Terraform release page and stick it into an object
        $releasePageURL = "https://releases.hashicorp.com/terraform/"
        $tfReleases     = Invoke-WebRequest $releasePageURL -UseBasicParsing | Select-Object -ExpandProperty Content
        # We then want to pick out all the releases available
        $tfReleases     = $tfReleases -split "`n" | Select-String -Pattern "/terraform/([0-9]+\.[0-9]+\.[0-9]+)/" |
        ForEach-Object { $_.Matches | ForEach-Object { $_.Groups[1].Value}}
        # If version is set to latest, we download the latest release if it doesn't already exist in our working path
        if (($Version -eq "latest") -or ($Version -eq "l")) {
            $Version = $tfReleases[0]
            if (Get-ChildItem -Path "$tfPath/$Version" | Select-Object -Property Exists) {
                Write-Error "Version already exist"
                break
            }
        } elseif ($tfReleases -notcontains $Version) { # Stops everything if the version requested doesn't exist
            Write-Error "Invalid version"
            break
        } elseif ($tfReleases -contains $Version) {    # If the release exist, check wether or not it has already been downloaded
            if (Get-ChildItem -Path "$tfPath/$Version" -ErrorAction SilentlyContinue | Select-Object -Property Exists) {
                Write-Error "Version already exist"
                break
            } else { Write-Progress "Downloading Terraform v$Version" }
        } else {
            Write-Progress "Downloading Terraform v$Version"
        }
    }
    
    process {
        # Creating a temporary file to be used while downloading the release
        $tempFile       = [System.IO.Path]::GetTempFileName()

        # Downloading the release
        $downloadSplat = @{
            uri             = "https://releases.hashicorp.com/terraform/"+$version+"/terraform_"+$version+"_windows_amd64.zip"
            OutFile         = $tempFile
            UseBasicParsing = $true
        }
        Invoke-WebRequest @downloadSplat

        # Unzip that sucker!
        Export-ZipFile -ZipFile $tempFile -OutputFolder "$tfPath/$version"
    }
    # Don’t adventures ever have an end? 
    # I suppose not. Someone else always has to carry on the story.
    end {
        # Cleanup on isle "tempfolder"
        Remove-Item -Path $tempFile
    }
}