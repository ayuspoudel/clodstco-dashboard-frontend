provider "aws" {
  region = "us-east-1"
}


# VPC with public and private subnet
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

# Security group to allow internal traffic and SSH/WireGuard
module "ec2_sg" {
  source = "./modules/sg"
  name   = "clodstco-ec2-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      description = "allow all internal"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
    },
    {
      description = "allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "allow WireGuard"
      from_port   = 51820
      to_port     = 51820
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = local.tags
}

# EC2 instance (can be NAT, WireGuard, jump box)
module "ec2_instance" {
  source            = "./modules/ec2-instance"
  name              = "clodstco-gateway"
  ami_id            = "ami-020cba7c55df1f615" # Ubuntu 22.04 (us-east-1)
  instance_type     = "t2.micro"
  key_name          = "clodscto-keypair"         
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.ec2_sg.security_group_id
  source_dest_check = false                   # NAT-compatible
  tags              = local.tags
}
