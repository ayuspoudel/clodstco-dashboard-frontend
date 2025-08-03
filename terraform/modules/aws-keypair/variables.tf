variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "backup_to_ssm" {
  description = "Backup the private key to SSM Parameter Store"
  type        = bool
  default     = true
}

variable "local_backup" {
  description = "Backup the private key locally as .pem file (unsafe for production)"
  type        = bool
  default     = false
}
