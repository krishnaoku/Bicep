resource app_set 'Microsoft.Compute/availabilitySets@2020-12-01' = {
  name: 'app-set'
  location: 'East US'
  sku:{
    name:'Aligned'
  }
  properties:{
    platformFaultDomainCount:3
    platformUpdateDomainCount:5
  }
}
