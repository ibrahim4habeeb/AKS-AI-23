resource_group_name = "aks_egress_rg_Fire"
resource_group_location = "japaneast"
#resource_group_location = "eastus"
vnet_name = "vnet-backend-001"
vnet_address_space = ["10.0.0.0/8"]

snet1_subnet_name = "snet-privatelinkservice-backend"
snet1_subnet_address = ["10.3.1.0/24"]

snet2_subnet_name = "snet-internalendpoint-backend"
snet2_subnet_address = ["10.3.0.0/24"]

# snet3_subnet_name = "snet-aks-backend"
# snet3_subnet_address = ["10.0.0.0/16"]

snet5_subnet_name = "snet-privatelinkendpoint-backend"
snet5_subnet_address = ["10.3.5.0/24"]

snet6_subnet_name = "snet-maintainance-backend"
snet6_subnet_address = ["10.3.3.0/24"]

snet7_subnet_name = "snet-vmapps-backend"
snet7_subnet_address = ["10.4.0.0/16"]

bastion_service_subnet_name = "AzureBastionSubnet"
bastion_service_address_prefixes = ["10.3.2.0/24"]

#Azure Key Vault input variables
secret_name = "vmpassword"
secret_value = "P@$$word!@#"

# AzureFirewall_subnet_name = "AzureFirewallSubnet"
# AzureFirewall_address_prefixes = ["10.3.6.0/24"]