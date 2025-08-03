variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "tags" {
  description = "Tags for the instance"
  type        = map(string)
  default     = {}
}

variable "source_dest_check" {
  description = "Enable/disable source-destination check"
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  description = "Assign public IP address"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "Startup script"
  type        = string
  default     = ""
}

variable "spot_instance" {
  description = "Launch as a spot instance"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "Availability zone (must match subnet AZ)"
  type        = string
}

variable "volume_size" {
  description = "Root EBS volume size (GB)"
  type        = number
  default     = 40
}

variable "volume_type" {
  description = "Root volume type"
  type        = string
  default     = "gp3"
}

variable "root_device_name" {
  description = "Device name for root volume"
  type        = string
  default     = "/dev/xvda"
}

variable "additional_ebs_volume" {
  description = "Optional secondary EBS volume"
  type = object({
    device_name = string
    volume_size = number
    volume_type = string
  })
  default = null
}
