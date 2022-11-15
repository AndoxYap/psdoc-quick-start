## resource group create + deploy

az group create --name bicep-acr-rg --location centralus

az deployment group create --resource-group bicep-acr-rg --template-file ACR-basic\deploy.bicep

<!-- --parameters v3\deployment\parameters.json -->

az deployment group what-if --resource-group bicep-acr-rg --template-file ACR-basic\deploy.bicep

<!-- --parameters v3\deployment\parameters.json -->

## Generate arm templates from bicep with bicep cli

    az bicep build --file templates/deploy.bicep


## V1: psdoc out template Docs. Work for own single level. Use v2 for better results.

Set-Location -Path "D:\OwnRepo\SoftwareEngineer\Full-Time\RPS\NewBHI\newbhi-core-infrastructure\bicep"

Install-Module -Name 'PSDocs.Azure' -Repository PSGallery -Force;
Get-AzDocTemplateFile -Path modules/ | ForEach-Object {
Invoke-PSDocument -Module PSDocs.Azure -OutputPath out/docs/ -InputObject $\_.TemplateFile -Convention 'Azure.NameByParentPath';
}

## V2: Import module. Working For newbhi core infra Modules.

### In pwsh, generate arm templates for subdirectories (bhi core). Refer: https://stackoverflow.com/questions/71940586/publish-multiple-bicep-templates-to-a-container-registry

Set-Location -Path  "D:\OwnRepo\SoftwareEngineer\Full Time\RPS\NewBHI\newbhi-core-infrastructure\bicep"
 $modules = Get-ChildItem -Path .\modules\*.bicep -Recurse -Force -Exclude *.tests.bicep
        foreach ($module in $modules){
             az bicep build --file $module
        }
### Then, to generate markdown:
Set-Location -Path "D:\OwnRepo\SoftwareEngineer\Full-Time\RPS\NewBHI\newbhi-core-infrastructure\bicep"
Import-Module PSDocs.Azure;

#### Scan for Azure template file recursively in the templates/ directory
Get-AzDocTemplateFile -Path modules/ | ForEach-Object {
    # Generate a standard name of the markdown file. i.e. <name>_<version>.md
    $template = Get-Item -Path $_.TemplateFile;
    $templateName = $template.Directory.Parent.Name;
    $version = $template.Directory.Name;
    $docName = "$($templateName)_$version";

    # Generate markdown
    Invoke-PSDocument -Module PSDocs.Azure -OutputPath out/docs/ -InputObject $template.FullName -InstanceName $docName;
}

## V2.1: Import module. Working For newbhi core infra Deployments.
### In pwsh, generate arm templates for subdirectories (bhi core). Refer: https://stackoverflow.com/questions/71940586/publish-multiple-bicep-templates-to-a-container-registry
Set-Location -Path "D:\OwnRepo\SoftwareEngineer\Full-Time\RPS\NewBHI\newbhi-core-infrastructure\bicep\deployments\NewBHI\landing-zones"
 $modules = Get-ChildItem -Path .\RPS-AAP-Dev\*.bicep -Recurse -Force -Exclude *.tests.bicep
        foreach ($module in $modules){
             az bicep build --file $module
        }
### Then, set below to generate markdown:
Set-Location -Path "D:\OwnRepo\SoftwareEngineer\Full-Time\RPS\NewBHI\newbhi-core-infrastructure\bicep\deployments\NewBHI\landing-zones"
Import-Module PSDocs.Azure;
#### Scan for Azure template file recursively in the templates/ directory
Get-AzDocTemplateFile -Path RPS-AAP-Dev/ | ForEach-Object {
    # Generate a standard name of the markdown file. i.e. <name>_<version>.md
    $template = Get-Item -Path $_.TemplateFile;
    $templateName = $template.Directory.Parent.Name;
    $version = $template.Directory.Name;
    $docName = "$($templateName)_$version";

    # Generate markdown
    Invoke-PSDocument -Module PSDocs.Azure -OutputPath out/docs/ -InputObject $template.FullName -InstanceName $docName;
}

<!-- ## v3
Get-AzDocTemplateFile -Path modules/ | ForEach-Object {
    Invoke-PSDocument -Module PSDocs.Azure -InputPath . -Convention 'Azure.NameByParentPath' -OutputPath 'out/docs/'
} -->
