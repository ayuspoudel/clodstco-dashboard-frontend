### `modules/remote-backend/README.md`

```md
## Remote Backend Module

This module provisions an S3 bucket and DynamoDB table for storing and locking Terraform state.

### Inputs

- `bucket_name`: Name of the S3 bucket to create.
- `lock_table_name`: Name of the DynamoDB table (default is `terraform-locks`).
- `tags`: Tags to apply to both resources.

### Outputs

- `bucket_name`: The name of the created S3 bucket.
- `lock_table_name`: The name of the created DynamoDB table.

### Example Usage

```hcl
module "remote_backend" {
  source          = "../modules/remote-backend"
  bucket_name     = "clodstco-terraform-state"
  lock_table_name = "terraform-locks"
  tags = {
    environment = "dev"
    owner       = "clodstco"
  }
}
```

**After running terraform apply, reference the bucket and table in your backend block in main.tf.**

```hcl
terraform {
  backend "s3" {
    bucket         = "clodstco-terraform-state"
    key            = "dev/github-oidc/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```