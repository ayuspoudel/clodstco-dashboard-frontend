variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the security group"
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "CIDR blocks allowed to access RDS"
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}
