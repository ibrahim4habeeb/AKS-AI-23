# Resource-1: Create WebTier Subnet
resource "azurerm_subnet" "snet1" {
  name                 = var.snet1_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.snet1_subnet_address 
}

# Resource-2: Create Network Security Group (NSG)
resource "azurerm_network_security_group" "snet1_nsg" {
  name                = "${azurerm_subnet.snet1.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-3: Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "snet1_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.snet1_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                 = azurerm_subnet.snet1.id
  network_security_group_id = azurerm_network_security_group.snet1_nsg.id
}

# Resource-4: Create NSG Rules
## Locals Block for Security Rules
locals {
  snet1_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22"
  } 
}
## NSG Inbound Rule for WebTier Subnets
resource "azurerm_network_security_rule" "snet1_nsg_rule_inbound" {
  for_each = local.snet1_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.snet1_nsg.name
}