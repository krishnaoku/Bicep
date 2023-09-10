@description('please specify a location')
param location string
var networkname='bicepvirtual_nw'
var networkAddressPrefix='10.0.0.0/16'

resource bicepvirtual_nw 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: networkname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        networkAddressPrefix
      ]
    }
    subnets: [ for i in range (1,3):{
        name: 'Subnet${i}'
        properties: {
          addressPrefix: cidrSubnet(networkAddressPrefix,24,i)
        }
      }]
  }
}
