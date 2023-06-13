#User_Define_Route_to_snet1
resource "azurerm_route_table" "User_Define_Route_to_snet1" {
  depends_on = [azurerm_firewall.fw]
  name                          = "User-Define-Route-ro-snet1"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                 = "UDR-to-snet-1"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_snet1" {
  depends_on = [azurerm_route_table.User_Define_Route_to_snet1]
  subnet_id      = azurerm_subnet.snet1.id
  route_table_id = azurerm_route_table.User_Define_Route_to_snet1.id
}

#User_Define_Route_to_snet2
resource "azurerm_route_table" "User_Define_Route_to_snet2" {
  depends_on = [azurerm_firewall.fw]
  name                          = "User-Define-Route-ro-snet2"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                 = "UDR-to-snet-2"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_snet2" {
  depends_on = [azurerm_route_table.User_Define_Route_to_snet2]
  subnet_id      = azurerm_subnet.snet2.id
  route_table_id = azurerm_route_table.User_Define_Route_to_snet2.id
}

#User_Define_Route_to_snet4
resource "azurerm_route_table" "User_Define_Route_to_snet4" {
  depends_on = [azurerm_firewall.fw]
  name                          = "User-Define-Route-ro-snet4"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                 = "UDR-to-snet-4"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_snet4" {
  depends_on = [azurerm_route_table.User_Define_Route_to_snet4]
  subnet_id      = azurerm_subnet.snet4.id
  route_table_id = azurerm_route_table.User_Define_Route_to_snet4.id
}

#User_Define_Route_to_snet5
resource "azurerm_route_table" "User_Define_Route_to_snet5" {
  depends_on = [azurerm_firewall.fw]
  name                          = "User-Define-Route-ro-snet5"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                 = "UDR-to-snet-5"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_snet5" {
  depends_on = [azurerm_route_table.User_Define_Route_to_snet5]
  subnet_id      = azurerm_subnet.snet5.id
  route_table_id = azurerm_route_table.User_Define_Route_to_snet5.id
}

#User_Define_Route_to_snet6
resource "azurerm_route_table" "User_Define_Route_to_snet6" {
  depends_on = [azurerm_firewall.fw]
  name                          = "User-Define-Route-ro-snet6"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                 = "UDR-to-snet-6"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_snet6" {
  depends_on = [azurerm_route_table.User_Define_Route_to_snet6]
  subnet_id      = azurerm_subnet.snet6.id
  route_table_id = azurerm_route_table.User_Define_Route_to_snet6.id
}

#User_Define_Route_to_snet7
resource "azurerm_route_table" "User_Define_Route_to_snet7" {
  depends_on = [azurerm_firewall.fw]
  name                          = "User-Define-Route-ro-snet7"
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  disable_bgp_route_propagation = false

  route {
    name                 = "UDR-to-snet-7"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_snet7" {
  depends_on = [azurerm_route_table.User_Define_Route_to_snet7]
  subnet_id      = azurerm_subnet.snet7.id
  route_table_id = azurerm_route_table.User_Define_Route_to_snet7.id
}
