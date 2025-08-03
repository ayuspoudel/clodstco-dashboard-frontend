variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t3.micro)"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to launch the instance in"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to associate with the instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the instance and any volumes"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "source_dest_check" {
  description = "Enable or disable source/destination checking"
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "Optional startup script for the instance"
  type        = string
  default     = ""
}

variable "spot_instance" {
  description = "Launch instance as a Spot instance"
  type        = bool
  default     = false
}

variable "volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 40
}

variable "volume_type" {
  description = "Type of the root EBS volume (e.g., gp3)"
  type        = string
  default     = "gp3"
}

variable "additional_ebs_volume" {
  description = "Optional configuration for a secondary EBS volume"
  type = object({
    device_name = string
    volume_size = number
    volume_type = string
  })
  default = null
}
