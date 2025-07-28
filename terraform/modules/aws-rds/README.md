rds module for clodstco project

creates:
- postgres rds instance with subnet group and sg

inputs:
- name: name prefix for resources
- identifier: rds instance name
- db_name: name of the database
- username: master username
- password: master password (optional if manage_master_user_password = true)
- manage_master_user_password: use secrets manager if true
- engine: postgres, default
- engine_version: default 15.3
- instance_class: default db.t3.micro
- allocated_storage: default 20
- multi_az: bool
- subnet_ids: list of subnet ids
- vpc_security_group_ids: list of sg ids
- publicly_accessible: bool
- tags: map of tags

outputs:
- db_instance_id
- db_instance_endpoint
- db_instance_arn

use:
module "rds" {
  source                   = "../modules/rds"
  name                     = "clodstco"
  identifier               = "clodstco-db"
  db_name                  = "clodstco"
  username                 = "postgres"
  subnet_ids               = module.vpc.private_subnet_ids
  vpc_security_group_ids   = [module.rds_sg.security_group_id]
  tags                     = local.tags
}
