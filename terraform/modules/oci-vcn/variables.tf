# Input variables for oci-vcn module
variable "name" {
  description = "Name prefix for VCN and subnet"
  type        = string
}

variable "compartment_ocid" {
  description = "OCID of the compartment"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block for the VCN"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}
variable "tags" {
  description = "Map of freeform tags to apply"
  type        = map(string)
  default     = {}
}
