resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags = merge(var.tags, {
    Name = "${var.name}-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier              = var.identifier
  db_name                 = var.db_name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  port                    = var.port
  multi_az                = var.multi_az
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  parameter_group_name    = var.parameter_group_name
  publicly_accessible     = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  final_snapshot_identifier = var.final_snapshot_identifier

  manage_master_user_password = var.manage_master_user_password
  # alternatively, use `password = var.password` if not using AWS Secrets Manager

  tags = merge(var.tags, {
    Name = var.identifier
  })
}
