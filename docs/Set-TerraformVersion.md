---
external help file: tftools-help.xml
Module Name: tftools
online version: https://github.com/roberthstrand/tftools/docs/Set-TerraformVersion.md
schema: 2.0.0
---

# Set-TerraformVersion

## SYNOPSIS
Sets the active version of Terraform.

## SYNTAX

```
Set-TerraformVersion [-Version] <String> [<CommonParameters>]
```

## DESCRIPTION
Set the version of Terraform that you want active.
If the version doesn't exists in the library, it will ask to download the version.

## EXAMPLES

### EXAMPLE 1
```
Set-TerraformVersion
```

### EXAMPLE 2
```
Set-TerraformVersion -Version 0.13.1
```

### EXAMPLE 3
```
Set-TerraformVersion 0.13.1
```

## PARAMETERS

### -Version
Version of Terraform to set as active.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None. You cannot pipe objects to Set-TerraformVersion.
## OUTPUTS

### System string.
## NOTES

## RELATED LINKS

[https://github.com/roberthstrand/tftools/docs/Set-TerraformVersion.md](https://github.com/roberthstrand/tftools/docs/Set-TerraformVersion.md)

