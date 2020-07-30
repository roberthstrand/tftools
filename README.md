# tftools

[![Build Status](https://dev.azure.com/robstrdev/tftools/_apis/build/status/Crossplatform%20tests?branchName=master)](https://dev.azure.com/robstrdev/tftools/_build/latest?definitionId=1&branchName=master)

Terraform tools, a PowerShell module for Terraform administrators.

There are times where you have to use a certain version of the Terraform CLI tool, either because you have a defined version set in your code or you have configurations both in 0.12 and 0.11. With this tool you will be able to:

- Install the version of Terraform that you want, or the latest version
- List all versions of Terraform that you have installed
- Change between version of Terraform

## Installation

*If you already have Terraform installed by any other means, you want to remove that before installing Terraform with the module.*

Installation is pretty simple. The module is published on [powershellgallery](https://www.powershellgallery.com/packages/tftools), so all you need to do is the following.

```powershell
Install-Module -Name tftools
```

Updating the module:

```powershell
Update-Module -Name tftools
```

### OS compability checklist

- [X] Windows 10, PowerShell 7.02
- [X] Windows 10, PowerShell 5.1
- [X] Linux WSL
- [X] Ubuntu 20.04, 18.04
- [X] Mac
