vpc module for clodstco project

creates:
- vpc with dns support
- public subnets
- private subnets (only if enable_ha = true)
- internet gateway
- nat gateway (only if enable_ha = true)
- route tables and associations

inputs:
- name: prefix for naming resources
- vpc_cidr: main cidr block for vpc
- public_subnet_cidrs: list of public subnet cidrs
- private_subnet_cidrs: list of private subnet cidrs
- availability_zones: list of azs
- enable_ha: bool, enable ha or not
- tags: map of tags

outputs:
- vpc_id
- public_subnet_ids
- private_subnet_ids
- public_subnet_cidrs
- private_subnet_cidrs
- nat_gateway_id
- availability_zones_used
- public_route_table_id
- private_route_table_id

use:
module "vpc" {
  source               = "../modules/vpc"
  name                 = "clodstco"
  enable_ha            = false
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  availability_zones   = ["us-east-1a"]
  tags = {
    project = "clodstco"
  }
}
