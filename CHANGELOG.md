# tftools Release History

## 0.2.0 [2020-07-14]

### Linux functionality in order

Linux is operational. Starting to do testing on both Windows and Linux to make sure everything is working fine before making the code work on Mac as well.

## 0.1.0 [2020-07-13]

### Windows functionality in order

- Version control with Get and Set-TerraformVersion
- Remove-Terraform to delete versions from library 

Functionality tested in Windows 10. The module will be released to PowerShellGallery and made public, when I'm able to work out some kinks with PowerShellGet.

## 0.0.1 [2020-07-11]

### Initial release

- Added the cmdlet *Install-Terraform*
    - Creates a working directory (.tftools) under your home directory
    - Verifies the version one is trying to install
    - Checkes if the version is already installed
    - Downloads the release from HashiCorp and unzip it to the working directory, cataloged by version number