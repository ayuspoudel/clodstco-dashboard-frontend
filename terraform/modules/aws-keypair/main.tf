resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.generated.public_key_openssh
  tags       = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret" "key" {
  name        = "${var.key_name}-private-key"
  description = "EC2 Private Key for ${var.key_name}"
  recovery_window_in_days = 7

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "key" {
  secret_id     = aws_secretsmanager_secret.key.id
  secret_string = tls_private_key.generated.private_key_pem

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "backup_key" {
  count = var.backup_to_ssm ? 1 : 0

  name  = "/ec2/keypair/${var.key_name}/private_key"
  type  = "SecureString"
  value = tls_private_key.generated.private_key_pem
  tags  = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "local_file" "local_backup" {
  count           = var.local_backup ? 1 : 0
  filename        = "${path.module}/generated/${var.key_name}.pem"
  content         = tls_private_key.generated.private_key_pem
  file_permission = "0600"

  lifecycle {
    prevent_destroy = true
  }
}
