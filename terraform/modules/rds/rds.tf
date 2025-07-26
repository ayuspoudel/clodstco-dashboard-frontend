# modules/rds/rds.tf


resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_parameter_group" "this" {
  name   = var.parameter_group_name
  family = var.parameter_group_family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

resource "aws_security_group" "rds" {
  name        = var.sg_name
  description = "RDS security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = var.allowed_sg_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_db_instance" "postgres" {
  allocated_storage            = var.allocated_storage
  backup_retention_period      = var.backup_retention_period
  db_subnet_group_name         = aws_db_subnet_group.this.name
  engine                       = var.engine
  engine_version               = var.engine_version
  identifier                   = var.identifier
  instance_class               = var.instance_class
  multi_az                     = var.multi_az
  db_name                      = var.rds_name
  parameter_group_name         = aws_db_parameter_group.this.name
  manage_master_user_password  = var.manage_master_user_password
  port                         = var.port
  publicly_accessible          = var.publicly_accessible
  kms_key_id                   = var.kms_key_id
  storage_encrypted            = var.storage_encrypted
  storage_type                 = var.storage_type
  final_snapshot_identifier    = var.final_snapshot_identifier
  username                     = var.username
  vpc_security_group_ids       = [aws_security_group.rds.id]
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  monitoring_interval             = 60
  performance_insights_enabled   = true
  tags = merge(var.tags, {
    "creator" = var.creator
  })
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
