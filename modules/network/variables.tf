variable "project_name" {
  description = "Prefix used for network resource names"
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

variable "vnet_address_space" {
  description = "CIDR block for the whole VNet"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet (jumpbox lives here)"
  type        = string
  default     = "10.20.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the private subnet (web VM lives here)"
  type        = string
  default     = "10.20.2.0/24"
}

variable "tags" {
  description = "Tags applied to network resources"
  type        = map(string)
}
