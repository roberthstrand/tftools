---
external help file: tftools-help.xml
Module Name: tftools
online version: https://github.com/roberthstrand/tftools/docs/Set-TerraformVersion.md
schema: 2.0.0
---

# Install-Terraform

## SYNOPSIS
Installs the Terraform CLI tool.

## SYNTAX

```
Install-Terraform [[-Version] <String>] [-DisableLogo] [-SetAsActive] [<CommonParameters>]
```

## DESCRIPTION
Downloads and installs either a specific version of Terraform, or the latest one available.

## EXAMPLES

### EXAMPLE 1
```
Install-Terraform
```

### EXAMPLE 2
```
Install-Terraform -Version 0.13.1
```

### EXAMPLE 3
```
Install-Terraform 0.13.1 -SetAsActive
```

## PARAMETERS

### -Version
Version of Terraform to install.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableLogo
Disables the logo.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetAsActive
Automatically set the downloaded version as the active one.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to Install-Terraform.
## OUTPUTS

### System string.
## NOTES

## RELATED LINKS

[https://github.com/roberthstrand/tftools/docs/Set-TerraformVersion.md](https://github.com/roberthstrand/tftools/docs/Set-TerraformVersion.md)

