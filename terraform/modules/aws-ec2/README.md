

# AWS EC2 Module for Kubernetes Nodes

This Terraform module provisions an EC2 instance for use in a Kubernetes cluster or other infrastructure. It supports:

- On-demand or spot instances
- Optional public IP assignment
- Optional user data scripts for bootstrapping
- Inline `root_block_device` configuration (no manual volume attachment required)
- Optional additional (non-root) EBS volume
- Custom tagging for environment, role, or usage

---

## Requirements

- Terraform 1.3+
- AWS Provider
- Valid AWS credentials and key pair
- Pre-created VPC, subnet, and security group

---

## Inputs

| Variable               | Description                                                                 | Required | Default   |
|------------------------|-----------------------------------------------------------------------------|----------|-----------|
| `name`                 | Name of the EC2 instance                                                    | yes      | -         |
| `ami_id`               | AMI ID to launch                                                            | yes      | -         |
| `instance_type`        | Instance type (e.g., `t3.micro`, `t2.medium`)                               | yes      | -         |
| `key_name`             | Name of the AWS EC2 key pair                                                | yes      | -         |
| `subnet_id`            | Subnet ID to launch instance into                                           | yes      | -         |
| `security_group_id`    | Security group to associate with instance                                   | yes      | -         |
| `availability_zone`    | AZ for placing the instance and volumes                                     | yes      | -         |
| `volume_size`          | Root EBS volume size in GB                                                  | no       | `40`      |
| `volume_type`          | Root volume type (`gp3`, `gp2`, etc.)                                       | no       | `"gp3"`   |
| `associate_public_ip`  | Whether to assign a public IP                                               | no       | `false`   |
| `spot_instance`        | Launch the instance as a spot instance                                      | no       | `false`   |
| `user_data`            | Optional shell script to run on instance at boot                            | no       | `""`      |
| `source_dest_check`    | Enable source/destination check                                             | no       | `true`    |
| `tags`                 | Map of tags to apply to instance and resources                              | no       | `{}`      |
| `additional_ebs_volume`| Optional block for a secondary EBS volume                                   | no       | `null`    |

Example for `additional_ebs_volume`:

```hcl
additional_ebs_volume = {
  device_name = "/dev/sdf"
  volume_size = 100
  volume_type = "gp3"
}
````

---

## Outputs

| Output                 | Description                                         |
| ---------------------- | --------------------------------------------------- |
| `instance_id`          | EC2 instance ID                                     |
| `private_ip`           | Private IP address of the instance                  |
| `public_ip`            | Public IP address, if assigned                      |
| `additional_volume_id` | EBS volume ID of the additional volume (if created) |

---

## Example Usage

```hcl
module "k8s_worker_1" {
  source              = "../modules/aws-ec2"
  name                = "k8s-worker-1"
  ami_id              = "ami-020cba7c55df1f615"
  instance_type       = "t2.micro"
  key_name            = module.keypair.key_name
  subnet_id           = module.vpc.private_subnet_ids[0]
  security_group_id   = module.ec2_sg.security_group_id
  availability_zone   = "us-east-1a"
  volume_size         = 8
  volume_type         = "gp3"
  spot_instance       = true
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
```

---

## Notes

* This module uses `root_block_device` for the root volume and does not rely on `aws_ebs_volume` or `aws_volume_attachment` for root.
* If `additional_ebs_volume` is provided, a separate volume is created and attached.
* For Kubernetes, ensure the proper roles and bootstrap scripts are included via `user_data`.


