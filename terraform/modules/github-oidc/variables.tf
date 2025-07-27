variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "repo" {
  description = "GitHub repo in the form 'org/repo'"
  type        = string
}

variable "branch" {
  description = "GitHub branch"
  type        = string
  default     = "main"
}

variable "policy_arns" {
  description = "List of policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}
