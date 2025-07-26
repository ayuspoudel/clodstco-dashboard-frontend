variable "rds_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "manage_master_user_password" {
  description = "Whether to manage password with Secrets Manager"
  type        = bool
  default     = true
}

variable "allocated_storage" {
  description = "Storage in GB"
  type        = number
  default     = 20
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t4g.micro"
}

variable "engine" {
  description = "Database engine"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Engine version"
  type        = string
  default     = "15.5"
}

variable "multi_az" {
  description = "Enable multi-AZ deployment"
  type        = bool
  default     = false
}

variable "port" {
  description = "Port for DB access"
  type        = number
  default     = 5432
}

variable "db_subnet_group_name" {
  description = "Subnet group name"
  type        = string
}

variable "parameter_group_name" {
  description = "Parameter group name"
  type        = string
  default     = "default.postgres15"
}

variable "vpc_security_group_ids" {
  description = "List of VPC Security Group IDs"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the DB is publicly accessible"
  type        = bool
  default     = false
}

variable "storage_type" {
  description = "Type of storage (gp2, gp3, etc.)"
  type        = string
  default     = "gp3"
}

variable "storage_encrypted" {
  description = "Whether storage is encrypted"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "KMS key ID for encryption"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Days to retain backups"
  type        = number
  default     = 7
}

variable "final_snapshot_identifier" {
  description = "Snapshot name to use before deletion"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}

variable "creator" {
  description = "Creator label tag"
  type        = string
}
