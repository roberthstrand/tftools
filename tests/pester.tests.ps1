<#*-. PESTER .-*#>
# Import the module
BeforeAll {
    Import-Module -Name "$PSScriptRoot/../module/tftools.psd1" -Force -ErrorAction Stop
    # Check if a $profile exists, and create one if it doesn't.
    try {
        Test-Path $PROFILE.CurrentUserCurrentHost -ErrorAction Stop
    }
    catch {
        # Making sure the .config/powershell directories are present
        try {
            Test-Path $HOME/.config -ErrorAction Stop
        }
        catch {
            New-Item $HOME/.config -Type Directory
        }
        try {
            Test-Path $HOME/.config/powershell -ErrorAction Stop
        }
        catch {
            New-Item $HOME/.config/powershell -Type Directory
        }
        New-Item $PROFILE.CurrentUserCurrentHost | Out-Null
    }
    # Figure out what platform we are running on and set the appropriate variables
    . $PSScriptRoot/../module/src/helpers.ps1
    Set-PlatformVariables
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
        Install-Terraform -Version "Latest" -SetAsActive -DisableLogo
        Test-Path "$tfPath/*" | Should -be $true
    }
    # Downloads a specific version of Terraform, and checking that the correct version is present
    It 'Downloading a specific version and checking that Terraform is actually present with that version' {
        Install-Terraform -Version 0.12.25 -SetAsActive -DisableLogo
        $terraform = terraform -v
        $terraform -match "v0.12.25"
    }
}
Describe 'Checking Get-TerraformVersion' {
    It 'Should list all available versions of Terraform' {
        (Get-TerraformVersion -SilentlyRun).count | Should -BeGreaterThan 0
    }
}

Describe 'Checking Remove-Terraform' {
    It 'Should remove the specific versions of Terraform' {
        Remove-Terraform -Version "0.12.25" -Confirm:$false | Out-Null
        Test-Path -Path "$tfPath/0.12.25" | Should -Be $false
    }
}