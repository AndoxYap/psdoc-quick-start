## resource group create + deploy

az group create --name bicep-acr-rg --location centralus

az deployment group create --resource-group bicep-acr-rg --template-file ACR-basic\deploy.bicep

<!-- --parameters v3\deployment\parameters.json -->

az deployment group what-if --resource-group bicep-acr-rg --template-file ACR-basic\deploy.bicep

<!-- --parameters v3\deployment\parameters.json -->

## Generate arm templates from bicep with bicep cli

    az bicep build --file templates/deploy.bicep
### multi layer modules (bhi core) https://stackoverflow.com/questions/71940586/publish-multiple-bicep-templates-to-a-container-registry
cd to "D:\OwnRepo\SoftwareEngineer\Full Time\RPS\NewBHI\newbhi-core-infrastructure\bicep"
 $modules = Get-ChildItem -Path .\modules\*.bicep -Recurse -Force -Exclude *.tests.bicep
        foreach ($module in $modules){
             az bicep build --file $module
        } 

            <!-- $moduleName = $module.BaseName.ToLower() -->
            <!-- Write-Host "Adding new module ${moduleName} with version $version" -->
            <!-- az bicep publish --file $module.FullName --target br:${registryName}.azurecr.io/bicep/modules/${moduleName}:${version} -->

## psdoc out template Docs

Set-Location -Path "D:\OwnRepo\SoftwareEngineer\Full Time\RPS\NewBHI\newbhi-core-infrastructure\bicep"

Install-Module -Name 'PSDocs.Azure' -Repository PSGallery -Force;
Get-AzDocTemplateFile -Path modules/ | ForEach-Object {
Invoke-PSDocument -Module PSDocs.Azure -OutputPath out/docs/ -InputObject $\_.TemplateFile -Convention 'Azure.NameByParentPath';
}
