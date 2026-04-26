variable "project_name" {
  description = "Prefix used for security resource names"
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

variable "allowed_ssh_cidr" {
  description = "Public CIDR allowed to SSH into the jumpbox"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR of the public subnet (used in private NSG rule)"
  type        = string
}

variable "tags" {
  description = "Tags applied to security resources"
  type        = map(string)
}
