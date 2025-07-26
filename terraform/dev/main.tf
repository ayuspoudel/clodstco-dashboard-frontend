provider "aws" {
  region = "us-east-1"
}

locals {
  tags = {
    project     = "clodstco"
    environment = "dev"
  }
}

module "vpc" {
  source               = "./modules/vpc"
  name                 = "clodstco"
  enable_ha            = false
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  availability_zones   = ["us-east-1a"]
  tags                 = local.tags
}

module "eks_sg" {
  source = "./modules/sg"
  name   = "clodstco-eks-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "allow all internal"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]

  tags = local.tags
}

module "eks" {
  source              = "./modules/eks"
  name                = "clodstco"
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [module.eks_sg.security_group_id]
  kubernetes_version  = "1.29"
  node_instance_type  = "t3.medium"
  node_min_size       = 1
  node_max_size       = 1
  node_desired_size   = 1
  tags                = local.tags
}
