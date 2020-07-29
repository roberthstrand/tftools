# *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~* #
# ~~ Collection of helper functions used with the tftools module ~~ #
# *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~* #
function Write-tftoolsLogo {
    Write-Host "   __  ______              __    " -ForegroundColor Magenta
    Write-Host "  / /_/ __/ /_____  ____  / /____" -ForegroundColor Magenta
    Write-Host " / __/ /_/ __/ __ \/ __ \/ / ___/" -ForegroundColor DarkMagenta
    Write-Host "/ /_/ __/ /_/ /_/ / /_/ / (__  ) " -ForegroundColor DarkMagenta
    Write-Host "\__/_/  \__/\____/\____/_/____/  " -ForegroundColor DarkMagenta
    Write-Host "                      v0.3.5     " -ForegroundColor DarkGray
}
# This one is pretty cool, and we could probably have used a different
# module for working with Zip files but this is a cool scripting exercise
function Export-ZipFile {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ZipFile,
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $OutputFolder
    )
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipFile, $OutputFolder)
}
function Set-PlatformVariables {
    if ($PSVersionTable.Platform -eq "Win32NT") {
        # Windows, PowerShell 6+
        Add-tfProfile
        $global:tfPath = $env:USERPROFILE + "\.tftools"
        $global:machineOS = "windows_amd64"
        $global:execDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
    }
    elseif ($PSVersionTable.OS -like "Linux*") {
        Add-tfProfile -unix
        $global:tfPath = $HOME + "/.tftools"
        $global:machineOS = "linux_amd64"
        if ($env:PATH -notlike "*$tfPath*") {
            $env:PATH += $tfPath
            '{0} += "{1}"' -f '$env:PATH', ":$tfPath" | Add-Content -Path $PROFILE
        }
    }
    elseif ($PSVersionTable.OS -like "Darwin*") {
        Add-tfProfile -unix
        $global:tfPath = $HOME + "/.tftools"
        $global:machineOS = "darwin_amd64"
        if ($env:PATH -notlike "*$tfPath*") {
            $env:PATH += $tfPath
            '{0} += "{1}"' -f '$env:PATH', ":$tfPath" | Add-Content -Path $PROFILE
        }
    }
    elseif (!$PSVersionTable.Platform) {
        # Windows, Windows PowerShell
        Add-tfProfile
        $global:tfPath = $env:USERPROFILE + "\.tftools" 
        $global:machineOS = "windows_amd64"
        $global:execDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
    }
}
function Add-tfProfile {
    param (
        [switch]
        $unix
    )
    switch ($unix) {
        $true {
            New-Item $HOME/.config -Type Directory -ErrorAction SilentlyContinue
            New-Item $HOME/.config/powershell -Type Directory -ErrorAction SilentlyContinue
            New-Item $PROFILE -ErrorAction SilentlyContinue
        }
        default {
            New-Item $PROFILE -ErrorAction SilentlyContinue
        }
    }
}