# Create a resource group
resource "azurerm_resource_group" "dev-rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "dev-vnet" {
  name                = var.vnet
  resource_group_name = azurerm_resource_group.dev-rg.name
  location            = azurerm_resource_group.dev-rg.location
  address_space       = var.address_prefixes.vnet
}