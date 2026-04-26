output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "jumpbox_public_ip" {
  description = "Public IP of the jumpbox"
  value       = module.compute.jumpbox_public_ip
}

output "web_private_ip" {
  description = "Private IP of the web VM"
  value       = module.compute.web_private_ip
}

# Handy copy-paste commands after apply.
output "ssh_to_jumpbox" {
  description = "SSH command for the jumpbox"
  value       = "ssh ${var.admin_username}@${module.compute.jumpbox_public_ip}"
}

output "ssh_to_web_from_jumpbox" {
  description = "Run this from inside the jumpbox to reach the web VM"
  value       = "ssh ${var.admin_username}@${module.compute.web_private_ip}"
}
