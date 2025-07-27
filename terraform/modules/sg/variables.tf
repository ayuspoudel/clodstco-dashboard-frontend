variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rule objects"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    description      = optional(string)
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
  }))
}

variable "egress_rules" {
  description = "List of egress rule objects"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    description      = optional(string)
    cidr_blocks      = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    prefix_list_ids  = optional(list(string))
  }))
  default = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow all egress"
    cidr_blocks = ["0.0.0.0/0"]
  }]
}

variable "tags" {
  description = "Map of tags to apply to the security group"
  type        = map(string)
}
