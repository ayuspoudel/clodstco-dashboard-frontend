provider "aws" {
  region = "us-east-1"
}

module "keypair" {
  source          = "../modules/aws-keypair"
  key_name        = "clodstco-keypair"
  backup_to_ssm   = true
  local_backup    = false
  tags            = local.tags
}

module "vpc" {
  source               = "../modules/aws-vpc"
  name                 = "clodstco"
  enable_ha            = false
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  availability_zones   = [local.az]
  tags                 = local.tags
}

module "ec2_sg" {
  source = "../modules/aws-sg"
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

module "bastion_instance" {
  source              = "../modules/aws-ec2"
  name                = "clodstco-bastion"
  ami_id              = "ami-020cba7c55df1f615"
  instance_type       = "t2.micro"
  key_name            = module.keypair.key_name
  subnet_id           = module.vpc.public_subnet_ids[0]
  security_group_id   = module.ec2_sg.security_group_id
  source_dest_check   = false
  availability_zone   = local.az
  associate_public_ip = true
  volume_size         = 8
  volume_type         = "gp3"

  tags = merge(local.tags, {
    Name    = "clodstco-bastion"
    role    = "ssh-bastion"
    purpose = "jump-host"
  })
}

module "k8s_master" {
  source              = "../modules/aws-ec2"
  name                = "k8s-master-1"
  ami_id              = "ami-020cba7c55df1f615"
  instance_type       = "t2.micro"
  key_name            = module.keypair.key_name
  subnet_id           = module.vpc.private_subnet_ids[0]
  security_group_id   = module.ec2_sg.security_group_id
  source_dest_check   = false
  availability_zone   = local.az
  associate_public_ip = false
  spot_instance       = false
  volume_size         = 8
  volume_type         = "gp3"

  tags = merge(local.tags, {
    "kubernetes-role" = "master"
  })
}

module "k8s_worker_1" {
  source              = "../modules/aws-ec2"
  name                = "k8s-worker-1"
  ami_id              = "ami-020cba7c55df1f615"
  instance_type       = "t2.micro"
  key_name            = module.keypair.key_name
  subnet_id           = module.vpc.private_subnet_ids[0]
  security_group_id   = module.ec2_sg.security_group_id
  source_dest_check   = false
  availability_zone   = local.az
  associate_public_ip = false
  spot_instance       = true
  volume_size         = 8
  volume_type         = "gp3"

  tags = merge(local.tags, {
    "kubernetes-role" = "worker"
  })
}
