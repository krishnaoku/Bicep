resource app_ip 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'app_ip'
  location: 'East US'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
