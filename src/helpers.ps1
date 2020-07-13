# *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~* #
# ~~ Collection of helper functions used with the tftools module ~~ #
# *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~* #
function Write-tftoolsLogo {
    Write-Host "   __  ______              __    " -ForegroundColor Magenta
    Write-Host "  / /_/ __/ /_____  ____  / /____" -ForegroundColor Magenta
    Write-Host " / __/ /_/ __/ __ \/ __ \/ / ___/" -ForegroundColor DarkMagenta
    Write-Host "/ /_/ __/ /_/ /_/ / /_/ / (__  ) " -ForegroundColor DarkMagenta
    Write-Host "\__/_/  \__/\____/\____/_/____/  " -ForegroundColor DarkMagenta
    Write-Host "                      v0.0.1     " -ForegroundColor DarkGray
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
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $OutputFolder
    )
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipFile, $OutputFolder)
}