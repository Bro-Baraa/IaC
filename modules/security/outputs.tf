output "public_nsg_id" {
  description = "ID of the public NSG"
  value       = azurerm_network_security_group.public.id
}

output "private_nsg_id" {
  description = "ID of the private NSG"
  value       = azurerm_network_security_group.private.id
}
