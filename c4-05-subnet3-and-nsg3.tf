# resource "azurerm_resource_group" "aks_egress_rg" {
#   name     = "aks-egress-rg"
#   location = "japaneast"
# }

# resource "azurerm_virtual_network" "aks_vnet" {
#   name                = "aks-vnet"
#   address_space       = ["10.0.0.0/8"]
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks_subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/16"]
  #route_table_id       = azurerm_route_table.aks_egress_fwrt.id
}

resource "azurerm_subnet" "fw_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.3.6.0/24"]
}

resource "azurerm_public_ip" "fw_public_ip" {
  name                = "fw-public-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "fw" {
  name                = "fw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  ip_configuration {
    name                 = "fw-ip-config"
    subnet_id            = azurerm_subnet.fw_subnet.id
    public_ip_address_id = azurerm_public_ip.fw_public_ip.id
  }
  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id
  depends_on = [azurerm_firewall_policy.firewallpolicy]
}

resource "azurerm_firewall_policy" "firewallpolicy" {
  name                = "firewallpolicy"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  dns {
      proxy_enabled = "true"
  }
}

# Resource: Associate user define routing table to subnet
resource "azurerm_subnet_route_table_association" "UDR_asso_to_aks_subnet" {
  depends_on = [azurerm_route_table.aks_egress_fwrt]
  subnet_id      = azurerm_subnet.aks_subnet.id
  route_table_id = azurerm_route_table.aks_egress_fwrt.id
}

resource "azurerm_route_table" "aks_egress_fwrt" {
  depends_on = [azurerm_firewall.fw]
  name                = "aks-egress-fwrt"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  disable_bgp_route_propagation = false
  route {
    name                 = "aks-egress-fwrn"
    address_prefix       = "0.0.0.0/0"
    next_hop_type        = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  }
  route {
    name                 = "aks-egress-fwinternet"
    address_prefix      = "${azurerm_public_ip.fw_public_ip.ip_address}/32"
    
    next_hop_type       = "Internet"
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "rulecollection" {
  name               = "rulecollection"
  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id
  priority           = 500
  
  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 200
    action   = "Allow"
    rule {
      name                  = "AllowOutboundDNS"
      protocols             = ["UDP", "TCP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
    rule {
    name                  = "apiudp"
    # description           = "apiudp"
    protocols                 = ["UDP"]
    source_addresses          = ["*"]
    destination_addresses     = ["AzureCloud.japaneast"]
    destination_ports         = ["1194"]
    # action                    = "Allow"
  }
   rule {
    name                  = "apitcp"
    # description           = "apitcp"
    protocols                 = ["TCP"]
    source_addresses          = ["*"]
    destination_addresses     = ["AzureCloud.japaneast"]
    destination_ports         = ["9000"]
    # action                    = "Allow"
  }
  rule {
    name                  = "time"
    # description           = "time"
    protocols                 = ["UDP"]
    source_addresses          = ["*"]
    destination_fqdns         = ["ntp.ubuntu.com"]
    destination_ports         = ["123"]
    # action                    = "Allow"
  }

  }
  application_rule_collection {
    name     = "apprulecollection"
    priority = 400
    action   = "Allow"
    rule {
    name                 = "fqdn1"
    source_addresses     = ["*"]
    protocols {
      port = "80"
      type = "Http"
    }
    destination_fqdns           = ["AzureKubernetesService"]
  }
  rule {
    name                 = "fqdn2"
    source_addresses     = ["*"]
    protocols {
      port = "443"
      type = "Https"
    }
    destination_fqdns          = ["AzureKubernetesService"]
  }
    
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  depends_on = [azurerm_subnet_route_table_association.UDR_asso_to_aks_subnet]
  name                = "aks-egress"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-egress"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    type                 = "VirtualMachineScaleSets"
    vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  }

  # Identity (System Assigned or Service Principal)
  identity {
    type = "SystemAssigned"
  }

  network_profile {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    network_plugin = "azure"
    # load_balancer_sku = "standard"
    outbound_type  = "userDefinedRouting"
  }
}