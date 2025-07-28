# Input variables for oci-oke module
variable "name" {
  description = "OKE cluster name"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID where the cluster will be created"
  type        = string
}

variable "vcn_id" {
  description = "OCID of the VCN"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "v1.28.2"
}

variable "pods_cidr" {
  description = "CIDR block for pods"
  type        = string
  default     = "10.244.0.0/16"
}

variable "services_cidr" {
  description = "CIDR block for services"
  type        = string
  default     = "10.96.0.0/16"
}

variable "lb_subnet_ids" {
  description = "List of subnet IDs to attach the load balancer to"
  type        = list(string)
}
