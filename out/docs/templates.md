# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
acrName        | No       | A globally unique name of your Azure Container Registry
location       | No       | Location for the registry.
acrSku         | No       | Tier of your Azure Container Registry.

### acrName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

A globally unique name of your Azure Container Registry

- Default value: `[format('acr{0}', uniqueString(resourceGroup().id))]`

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Location for the registry.

- Default value: `[resourceGroup().location]`

### acrSku

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Tier of your Azure Container Registry.

- Default value: `Basic`

## Outputs

Name | Type | Description
---- | ---- | -----------
loginServer | string | Output the login server property for later use

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "templates/deploy.json"
    },
    "parameters": {
        "acrName": {
            "value": "[format('acr{0}', uniqueString(resourceGroup().id))]"
        },
        "location": {
            "value": "[resourceGroup().location]"
        },
        "acrSku": {
            "value": "Basic"
        }
    }
}
```

### Command line

#### PowerShell

```powershell
New-AzResourceGroupDeployment -Name <deployment-name> -ResourceGroupName <resource-group-name> -TemplateFile <path-to-template> -TemplateParameterFile <path-to-templateparameter>
```

#### Azure CLI

```text
az group deployment create --name <deployment-name> --resource-group <resource-group-name> --template-file <path-to-template> --parameters @<path-to-templateparameterfile>
```
