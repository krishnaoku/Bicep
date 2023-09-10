resource plan7777 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'plan7777'
  location: 'East US'
  sku: {
    name: 'F1'
    capacity: 1
  }
  properties:{}
}

resource webApp7777 'Microsoft.Web/sites@2021-01-15' = {
  name: 'webApp7777'
  location: 'East US'
  properties: {
    serverFarmId: plan7777.id
    siteConfig:{
      netFrameworkVersion:'6.0'
    }
  }
}
