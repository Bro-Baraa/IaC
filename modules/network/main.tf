resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.project_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_address_space]
  tags                = var.tags
}

# Public subnet - holds the jumpbox.
resource "azurerm_subnet" "public" {
  name                 = "snet-${var.project_name}-public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.public_subnet_cidr]
}

# Private subnet - holds the web VM. No public IP attached.
resource "azurerm_subnet" "private" {
  name                 = "snet-${var.project_name}-private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_subnet_cidr]
}
