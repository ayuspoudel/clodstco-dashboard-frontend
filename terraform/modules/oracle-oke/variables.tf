variable "compartment_id" {
  type = string
}

variable "name" {
  type = string
}

variable "availability_domain" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "v1.29.1"
}

variable "node_shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_image_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "pods_cidr" {
  type    = string
  default = "10.244.0.0/16"
}

variable "services_cidr" {
  type    = string
  default = "10.96.0.0/16"
}

variable "enable_public_kube" {
  type    = bool
  default = false
}
