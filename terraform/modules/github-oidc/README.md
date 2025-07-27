## GitHub OIDC Module

This module sets up GitHub Actions OIDC integration for Terraform deployments. It creates an OpenID Connect provider and a role with trust policy for a specific GitHub repo and branch.

### Inputs

- `role_name`: Name of the IAM role to create.
- `repo`: GitHub repository in the format `org/repo`.
- `branch`: GitHub branch to allow (default is `main`).
- `policy_arns`: List of IAM policy ARNs to attach to the role.

### Outputs

- `role_arn`: ARN of the IAM role that can be assumed by GitHub Actions.

### Example Usage

```hcl
module "github_oidc" {
  source     = "../modules/github-oidc"
  role_name  = "gha-deploy-role"
  repo       = "your-org/your-repo"
  branch     = "main"
  policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
}
