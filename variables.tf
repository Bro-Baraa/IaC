variable "project_name" {
  description = "Short name used as a prefix for Azure resources"
  type        = string
  default     = "baraa-lab"
}

variable "location" {
  description = "Azure region for the lab"
  type        = string
  default     = "westeurope"
}

variable "admin_username" {
  description = "Admin user for the Linux VMs"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to your SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Keep this tight. /32 means only your IP can reach the jumpbox on port 22.
variable "allowed_ssh_cidr" {
  description = "Public IP range allowed to SSH into the jumpbox (use a /32)"
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "allowed_ssh_cidr must be a valid CIDR like 198.51.100.25/32."
  }
}

variable "tags" {
  description = "Tags applied to every resource"
  type        = map(string)
  default = {
    owner       = "Baraa"
    environment = "lab"
    project     = "azure-iaas"
    managed_by  = "terraform"
  }
}
