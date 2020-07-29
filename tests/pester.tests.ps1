<#*-. PESTER .-*#>
# Import the module
BeforeAll {
    Import-Module -Name "$PSScriptRoot/../module/tftools.psm1" -Force -ErrorAction Stop
    
    # Figure out what platform we are running on and set the appropriate variables
    . $PSScriptRoot/pester.helpers.ps1
    Set-PlatformVariables
    # Check if a $profile exists, and create one if it doesn't.
    switch (Test-Path $PROFILE.CurrentUserCurrentHost -ErrorAction Stop) {
        false {
            Write-Host "Checking if the .config folder is present..."
            Test-Path $HOME/.config
            Write-Host "Checking if the powershell config folder is present..."
            Test-Path $HOME/.config/powershell
            New-Item $HOME/.config/powershell -Type Directory
            New-Item $PROFILE.CurrentUserCurrentHost | Out-Null
        }
        Default {continue}
    }
}
Describe 'Making sure the module loaded correctly' {
    It 'checks that the module is present' {
        $module = Get-Module tftools
        $module | Should -Be $true
    }
}
# Testing cmdlets
Describe 'Checking Install-Terraform' {
    It 'Should install the latest version of Terraform' {
        Install-Terraform -Version "Latest" -SetAsActive
        Test-Path $tfPath | Should -be $true
    }
}
Describe 'Checking Get-TerraformVersion' {
    It 'Should list all available versions of Terraform' {
        (Get-TerraformVersion -SilentlyRun).count | Should -BeGreaterThan 0
    }
}