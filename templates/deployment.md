## resource group create + deploy

az group create --name bicep-acr-rg --location centralus

az deployment group create --resource-group bicep-acr-rg --template-file ACR-basic\deploy.bicep

<!-- --parameters v3\deployment\parameters.json -->

az deployment group what-if --resource-group bicep-acr-rg --template-file ACR-basic\deploy.bicep

<!-- --parameters v3\deployment\parameters.json -->

## Generate arm templates from bicep with bicep cli

    az bicep build --file templates/deploy.bicep

## psdoc out template Docs

Install-Module -Name 'PSDocs.Azure' -Repository PSGallery -Force;
Get-AzDocTemplateFile -Path templates/ | ForEach-Object {
Invoke-PSDocument -Module PSDocs.Azure -OutputPath out/docs/ -InputObject $\_.TemplateFile -Convention 'Azure.NameByParentPath';
}
