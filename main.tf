# Root module for Baraa's Azure IaaS lab.
# Wires together the network, security, and compute modules.

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}"
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "./modules/network"

  project_name        = var.project_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

module "security" {
  source = "./modules/security"

  project_name        = var.project_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allowed_ssh_cidr    = var.allowed_ssh_cidr
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id
  public_subnet_cidr  = module.network.public_subnet_cidr
  tags                = var.tags
}

module "compute" {
  source = "./modules/compute"

  project_name        = var.project_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  admin_username      = var.admin_username
  ssh_public_key_path = var.ssh_public_key_path
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id
  tags                = var.tags

  # NSGs must exist before the VMs are reachable, so make this explicit.
  depends_on = [module.security]
}
