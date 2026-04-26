output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = azurerm_subnet.private.id
}

# Re-exported so the security module can build NSG rules
# without hardcoding any CIDRs.
output "public_subnet_cidr" {
  description = "CIDR of the public subnet"
  value       = var.public_subnet_cidr
}

output "private_subnet_cidr" {
  description = "CIDR of the private subnet"
  value       = var.private_subnet_cidr
}
