resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' =[ for i in range(0,3): {
  name: '${i}appstorebicep843219'
  location: 'East US'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS' 
  }
}]
