output "jumpbox_public_ip" {
  description = "Public IP of the jumpbox"
  value       = azurerm_public_ip.jumpbox.ip_address
}

output "jumpbox_private_ip" {
  description = "Private IP of the jumpbox"
  value       = azurerm_network_interface.jumpbox.private_ip_address
}

output "web_private_ip" {
  description = "Private IP of the web VM"
  value       = azurerm_network_interface.web.private_ip_address
}
