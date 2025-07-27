locals {
  tags = {
    project         = "clodstco"
    environment     = "dev"
    owner           = "ayuspoudel"
    team            = "platform"
    repo            = "ayuspoudel/clodstco-dashboard-frontend"
    purpose         = "cloud-gateway" # can be rds / vpn / nat / general
    provisioned_by  = "Terraform"
    managed_by      = "IaC"
    created_by      = "github-actions"
  }
}  
