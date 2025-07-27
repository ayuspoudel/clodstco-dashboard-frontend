variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "lock_table_name" {
  description = "Name of the DynamoDB table for Terraform locking"
  type        = string
  default     = "terraform-locks"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {
    "project" = "clodstco"
  }
}
