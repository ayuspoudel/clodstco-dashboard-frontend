variable "name" {
  description = "IAM role name"
  type        = string
}

variable "assume_role_policy" {
  description = "JSON policy for who can assume this role"
  type        = string
}

variable "inline_policies" {
  description = "List of JSON policy documents to attach as inline policies"
  type        = list(any)
  default     = []
}

variable "managed_policy_arns" {
  description = "List of managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "service_account" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}

variable "managed_policy_arns" {
  type = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
