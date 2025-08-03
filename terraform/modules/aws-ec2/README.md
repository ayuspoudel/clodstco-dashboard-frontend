# AWS EC2 Module for Kubernetes Nodes

This Terraform module provisions an EC2 instance for use in a Kubernetes cluster. It supports:

- Spot or on-demand instances
- Optional public IP assignment
- Optional user data scripts for bootstrap
- Optional EBS data volume (non-root)
- External root and data volume attachment
- Tagging for Kubernetes roles

## Requirements

- Terraform 1.3+
- AWS provider
- Valid AWS credentials and key pair
- Pre-created VPC, subnets, and security group

## Inputs

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `name` | Name of the instance | yes | - |
| `ami_id` | AMI ID to use | yes | - |
| `instance_type` | EC2 instance type (e.g. t3.medium) | yes | - |
| `key_name` | SSH key name | yes | - |
| `subnet_id` | Subnet ID to launch in | yes | - |
| `security_group_id` | Security group ID | yes | - |
| `availability_zone` | Availability zone for EBS volumes | yes | - |
| `volume_size` | Root volume size in GB | no | 40 |
| `volume_type` | Root volume type | no | "gp3" |
| `root_device_name` | Device name for root volume | no | "/dev/xvda" |
| `additional_ebs_volume` | Optional additional volume object with `device_name`, `volume_size`, `volume_type` | no | null |
| `associate_public_ip` | Assign public IP address | no | false |
| `spot_instance` | Launch as a spot instance | no | false |
| `user_data` | User data script for instance provisioning | no | "" |
| `source_dest_check` | Enable source/destination check | no | true |
| `tags` | Map of tags to apply | no | {} |

## Outputs

| Output | Description |
|--------|-------------|
| `instance_id` | ID of the EC2 instance |
| `private_ip` | Private IP address |
| `public_ip` | Public IP address (if assigned) |
| `root_volume_id` | Root EBS volume ID |
| `additional_volume_id` | Additional EBS volume ID (if used) |

## Example

```hcl
module "k8s_worker_1" {
  source            = "../modules/aws-ec2"
  name              = "k8s-worker-1"
  ami_id            = "ami-020cba7c55df1f615"
  instance_type     = "t3.medium"
  key_name          = "clodscto-keypair"
  subnet_id         = module.vpc.private_subnet_ids[0]
  security_group_id = module.ec2_sg.security_group_id
  availability_zone = "us-east-1a"
  root_device_name  = "/dev/xvda"
  volume_size       = 50
  volume_type       = "gp3"
  spot_instance     = true
  associate_public_ip = false

  additional_ebs_volume = {
    device_name = "/dev/sdf"
    volume_size = 100
    volume_type = "gp3"
  }

  user_data = file("${path.module}/scripts/k8s-worker-bootstrap.sh")

  tags = {
    "kubernetes-role" = "worker"
    "environment"     = "dev"
  }
}
