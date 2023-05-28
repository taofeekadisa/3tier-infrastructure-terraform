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
