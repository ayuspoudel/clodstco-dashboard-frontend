resource "aws_security_group" "rds_sg" {
  name        = var.name
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow PostgreSQL"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
