# tftools

Terraform tools, a PowerShell module for Terraform administrators.

There are times where you have to use a certain version of the Terraform CLI tool, either because you have a defined version set in your code or you have configurations both in 0.12 and 0.11. With this tool you will be able to:

- Install the version of Terraform that you want, or the latest version
- List all versions of Terraform that you have installed
- Change between version of Terraform

## Installation

Installation is pretty simple. The module is published on [powershellgallery](https://www.powershellgallery.com/packages/tftools), so all you need to do is the following.

```powershell
Install-Module -Name tftools
```

Updating the module:

```powershell
Update-Module -Name tftools
```

## Note about Linux and Mac support
I don't want to create anything that isn't cross-platform but to get a minimum viable product I focused on getting Windows functionality in place first. At several points there are platform specific code, so this first release will not work on Mac or Linux. This is a high priority for me and will probably be fixed in a couple of days time.

### OS compability checklist

- [X] Windows 10, PowerShell 7.02
- [X] Windows 10, PowerShell 5.1
- [X] Ubuntu 20.04
- [X] Linux WSL
- [ ] Mac