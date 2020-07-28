# tftools Release History

## 0.2.5 [2020-07-29]

### Defining the latest version + bug fixes

From now on, if trying to download the latest version you will get the latest numbered only version. Example, if the latest version is 0.13.0-rc1 then the latest numbered version (0.12.29) will be downloaded. 

To download a beta or release candidate, you would now need to specify the version.

## 0.2.1 [2020-07-14]

### Bugfixes

Issues with running on Windows PowerShell 5.1 solved.

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
