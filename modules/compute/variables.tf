variable "project_name" {
  description = "Prefix used for compute resource names"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that owns these resources"
  type        = string
}

variable "admin_username" {
  description = "Admin user for both Linux VMs"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet (jumpbox NIC)"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet (web NIC)"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size for both VMs"
  type        = string
  default     = "Standard_B1s"
}

variable "tags" {
  description = "Tags applied to compute resources"
  type        = map(string)
}
