variable "aws_region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "clodstco-terraform-state"
}

variable "dynamodb_table" {
  default = "terraform-locks"
}

variable "github_repo" {
  description = "GitHub repository in org/repo format"
}

variable "github_branch" {
  default = "main"
}
