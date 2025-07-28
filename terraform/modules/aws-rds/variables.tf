variable "name" {
  description = "Name prefix for subnet group"
  type        = string
}

variable "identifier" {
  description = "RDS instance identifier"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password (ignored if manage_master_user_password = true)"
  type        = string
  default     = null
}

variable "manage_master_user_password" {
  description = "Whether to manage password via AWS Secrets Manager"
  type        = bool
  default     = true
}

variable "engine" {
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "storage_type" {
  type        = string
  default     = "gp2"
}

variable "storage_encrypted" {
  type        = bool
  default     = true
}

variable "kms_key_id" {
  type        = string
  default     = null
}

variable "multi_az" {
  type        = bool
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for subnet group"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs"
}

variable "parameter_group_name" {
  type        = string
  default     = "default.postgres15"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "final_snapshot_identifier" {
  type        = string
  default     = null
}

variable "port" {
  type        = number
  default     = 5432
}

variable "tags" {
  type        = map(string)
  default     = {}
}
