# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/8"]
}

# # snet3 Subnet Name
# variable "snet3_subnet_name" {
#   description = "Virtual Network snet3 Subnet Name"
#   type = string
#   default = "snet3"
# }
# # snet3 Subnet Address Space
# variable "snet3_subnet_address" {
#   description = "Virtual Network snet3 Subnet Address Spaces"
#   type = list(string)
#   default = ["10.0.0.0/16"]
# }

# snet1 Subnet Name
variable "snet1_subnet_name" {
  description = "Virtual Network snet1 Subnet Name"
  type = string
  default = "snet1"
}
# snet1 Subnet Address Space
variable "snet1_subnet_address" {
  description = "Virtual Network snet1 Subnet Address Spaces"
  type = list(string)
  default = ["10.3.1.0/24"]
}

# snet2 Subnet Name
variable "snet2_subnet_name" {
  description = "Virtual Network snet2 Subnet Name"
  type = string
  default = "snet2"
}
# snet2 Subnet Address Space
variable "snet2_subnet_address" {
  description = "Virtual Network snet2 Subnet Address Spaces"
  type = list(string)
  default = ["10.3.0.0/24"]
}

# snet4 Subnet Name
variable "snet4_subnet_name" {
  description = "Virtual Network snet4 Subnet Name"
  type = string
  default = "snet4"
}
# snet4 Subnet Address Space
variable "snet4_subnet_address" {
  description = "Virtual Network snet4 Subnet Address Spaces"
  type = list(string)
  default = ["10.2.0.0/16"]
}

# snet5 Subnet Name
variable "snet5_subnet_name" {
  description = "Virtual Network snet5 Subnet Name"
  type = string
  default = "snet5"
}
# snet5 Subnet Address Space
variable "snet5_subnet_address" {
  description = "Virtual Network snet5 Subnet Address Spaces"
  type = list(string)
  default = ["10.3.5.0/24"]
}

# snet6 Subnet Name
variable "snet6_subnet_name" {
  description = "Virtual Network snet6 Subnet Name"
  type = string
  default = "snet6"
}
# snet6 Subnet Address Space
variable "snet6_subnet_address" {
  description = "Virtual Network snet6 Subnet Address Spaces"
  type = list(string)
  default = ["10.3.3.0/24"]
}

# snet7 Subnet Name
variable "snet7_subnet_name" {
  description = "Virtual Network snet7 Subnet Name"
  type = string
  default = "snet7"
}
# snet7 Subnet Address Space
variable "snet7_subnet_address" {
  description = "Virtual Network snet7 Subnet Address Spaces"
  type = list(string)
  default = ["10.4.0.0/16"]
}


variable "ssh_public_key" {
  default = "~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"  
}

# # Create Virtual Network
# resource "azurerm_virtual_network" "aksvnet" {
#   name                = "aks-network"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   address_space       = ["10.0.0.0/8"]
# }

# # Create a Subnet for AKS
# resource "azurerm_subnet" "aks-default" {
#   name                 = "aks-default-subnet"
#   virtual_network_name = azurerm_virtual_network.aksvnet.name
#   resource_group_name  = azurerm_resource_group.rg.name
#   address_prefixes     = ["10.240.0.0/16"]
# }