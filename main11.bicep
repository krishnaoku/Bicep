@secure()
param adminPassword string
resource bicepvirtual_nw 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'bicepvirtual_nw'
  location: 'East US'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'SubnetA'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'SubnetB'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

resource app_ip 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'app_ip'
  location: 'East US'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
resource app_interface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'app-interface'
  location: 'East US'
  properties: {
    ipConfigurations: [
      {
        name: 'IPConfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets','bicepvirtual_nw','SubnetA')
          }
          publicIPAddress:{
            id: app_ip.id
          }
        }
      }
    ]
    networkSecurityGroup:{
      id:app_nsg.id
    }
  }
}
resource vmstorageac4645383 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'vmstorageac4645383'
  location: 'North Europe'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS' 
  }
}

resource app_nsg 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'app-nsg'
  location: 'East US'
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          description: 'Allow RDP Connection'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 111
          direction: 'Inbound'
        }
      }
    ]
  }
}
resource appvm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'appvm'
  location: 'East US'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2S_v3'
    }
    osProfile: {
      computerName: 'appvm'
      adminUsername: 'appadmin'
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'VMdiskOS'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id:app_interface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: reference(resourceId('Microsoft.Storage/storageAccounts/', toLower('vmstorageac4645383'))).primaryEndpoints.blod
      }
    }
  }
}
