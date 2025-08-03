# AWS Key Pair Module

This Terraform module generates a secure EC2 key pair and stores the private key in AWS Secrets Manager, with optional backup to AWS SSM Parameter Store and/or local disk.

---

## Features

- Generates a 4096-bit RSA EC2 key pair
- Creates a `tls_private_key` and uploads the public key to AWS using `aws_key_pair`
- Stores the private key in:
  - **AWS Secrets Manager** (default, required)
  - **AWS SSM Parameter Store** (optional backup)
  - **Local file** backup (`.pem`) – disabled by default
- Protects all sensitive resources with `prevent_destroy = true`
- Supports environment tagging and naming conventions

---

## Usage

```hcl
module "keypair" {
  source = "../modules/aws-keypair"

  key_name      = "clodstco-dev-key"
  backup_to_ssm = true
  local_backup  = false

  tags = {
    Environment = "dev"
    Owner       = "platform"
  }
}
