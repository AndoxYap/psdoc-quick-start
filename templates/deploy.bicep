@minLength(5)
@maxLength(50)
@description('A globally unique name of your Azure Container Registry')
param acrName string = 'acr${uniqueString(resourceGroup().id)}'

@description('Location for the registry.')
param location string = resourceGroup().location

@description('Tier of your Azure Container Registry.')
param acrSku string = 'Basic'

@description('Creates or update a Azure Container Registry.')
resource acrResource 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
  }
}

@description('Output the login server property for later use')
output loginServer string = acrResource.properties.loginServer
