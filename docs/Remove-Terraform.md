---
external help file: tftools-help.xml
Module Name: tftools
online version: https://github.com/roberthstrand/tftools/docs/Remove-Terraform.md
schema: 2.0.0
---

# Remove-Terraform

## SYNOPSIS
Removes a version of the Terraform CLI tool.

## SYNTAX

```
Remove-Terraform [-Version] <String> [-Confirm <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Removes a version of Terraform from the local version library.

## EXAMPLES

### EXAMPLE 1
```
Remove-Terraform
```

### EXAMPLE 2
```
Remove-Terraform -Version 0.13.1
```

## PARAMETERS

### -Version
Version of Terraform to remove.

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: Boolean
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

[https://github.com/roberthstrand/tftools/docs/Remove-Terraform.md](https://github.com/roberthstrand/tftools/docs/Remove-Terraform.md)

