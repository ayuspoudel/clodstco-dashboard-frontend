# Input variables for oci-sg module
variable "name" {
  type        = string
  description = "Display name for the security list"
}

variable "compartment_ocid" {
  type        = string
  description = "OCID of the compartment"
}

variable "vcn_id" {
  type        = string
  description = "VCN OCID to attach this security list to"
}

variable "ingress_rules" {
  type = list(object({
    protocol    = string         # "6" for TCP, "17" for UDP, "1" for ICMP, "all"
    source      = string         # CIDR block like "0.0.0.0/0"
    from_port   = number
    to_port     = number
    description = optional(string)
  }))
}

variable "egress_rules" {
  type = list(object({
    protocol     = string        # "all" or specific
    destination  = string
    description  = optional(string)
  }))
  default = null
}
variable "tags" {
  description = "Map of freeform tags to apply"
  type        = map(string)
  default     = {}
}
