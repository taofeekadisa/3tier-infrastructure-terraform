# Create a resource group
resource "azurerm_resource_group" "dev-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "dev-vnet" {
  name                = var.virtual_network.vnet
  resource_group_name = azurerm_resource_group.dev-rg.name
  location            = azurerm_resource_group.dev-rg.location
  address_space       = [var.virtual_network.address]
}

# Create 3 subnets
resource "azurerm_subnet" "dev-snet" {
  for_each             = var.sub_network
  name                 = each.key
  resource_group_name  = azurerm_resource_group.dev-rg.name
  virtual_network_name = azurerm_virtual_network.dev-vnet.name
  address_prefixes     = [each.value]
}

#Create 3 NSGs
resource "azurerm_network_security_group" "dev-nsg" {
  #count               = length(var.network_security_group)
  #name                = var.network_security_group[count.index]
  for_each            = var.network_security_group
  name                = each.value
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
}

#NSG-Subnets association
resource "azurerm_subnet_network_security_group_association" "nsg-snet" {
  for_each                  = { for subnet in azurerm_subnet.dev-snet : subnet.name => subnet }
  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.dev-nsg[each.key].id
}

#NSG Rules
resource "azurerm_network_security_rule" "web-nsg-rule" {
  for_each                    = local.web-nsg-rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.dev-rg.name
  network_security_group_name = var.network_security_group.web-snet
}

resource "azurerm_network_security_rule" "api-nsg-rule" {
  for_each                    = local.api-nsg-rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.dev-rg.name
  network_security_group_name = var.network_security_group.api-snet
}

resource "azurerm_network_security_rule" "db-nsg-rule" {
  for_each                    = local.db-nsg-rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.dev-rg.name
  network_security_group_name = var.network_security_group.db-snet
}