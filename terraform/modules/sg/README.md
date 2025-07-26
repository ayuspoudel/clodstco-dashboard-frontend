sg module for clodstco project

creates:
- security group with dynamic ingress and egress rules

inputs:
- name: name of the sg
- description: description of the sg
- vpc_id: id of the vpc
- ingress_rules: list of ingress rule objects
- egress_rules: list of egress rule objects (optional, defaults to allow all)
- tags: map of tags

outputs:
- security_group_id

use:
module "rds_sg" {
  source      = "../modules/sg"
  name        = "rds-sg"
  description = "allow db access"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags

  ingress_rules = [
    {
      description = "postgres from internal"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}
