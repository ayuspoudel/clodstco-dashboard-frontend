# Input variables for oci-instance module
variable "name" {
  description = "Instance name"
  type        = string
}

variable "compartment_ocid" {
  description = "OCID of the compartment"
  type        = string
}

variable "tenancy_ocid" {
  description = "OCID of the tenancy (for AD lookup)"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to launch instance into"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for access"
  type        = string
}

variable "shape" {
  description = "Instance shape"
  type        = string
  default     = "VM.Standard.E2.1.Micro" # Always Free
}

variable "source_dest_check" {
  description = "Whether to skip source/dest check (useful for NAT)"
  type        = bool
  default     = false
}
