resource app_interface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'app-interface'
  location: 'East US'
  properties: {
    ipConfigurations: [
      {
        name: 'Ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','bicepvirtual_nw','Subnet1')
          }
          publicIPAddress:{
            id: resourceId('Microsoft.Network/publicIPAddresses','app-ip')
          }
        }
      }
    ]
  }
}
 