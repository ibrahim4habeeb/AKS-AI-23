# Resource-1: Create snet7 Subnet
resource "azurerm_subnet" "snet7" {
  name                 = var.snet7_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet7_subnet_address 
}

# Resource-2: Create Network Security Group (NSG)
resource "azurerm_network_security_group" "snet7_nsg" {
  name                = "${azurerm_subnet.snet7.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-3: Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "snet7_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.snet7_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                 = azurerm_subnet.snet7.id
  network_security_group_id = azurerm_network_security_group.snet7_nsg.id
}

# Resource-4: Create NSG Rules
## Locals Block for Security Rules
locals {
  snet7_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  } 
}
## NSG Inbound Rule for WebTier Subnets
resource "azurerm_network_security_rule" "snet7_nsg_rule_inbound" {
  for_each = local.snet7_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefixes     = ["10.0.0.0/8"]
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.snet7_nsg.name
}