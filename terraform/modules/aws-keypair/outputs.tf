output "key_name" {
  value = aws_key_pair.this.key_name
}

output "secretsmanager_arn" {
  value = aws_secretsmanager_secret.key.arn
}

output "public_key" {
  value = tls_private_key.generated.public_key_openssh
}

output "local_backup_path" {
  value       = var.local_backup ? local_file.local_backup[0].filename : null
  description = "Path to local .pem file (if local_backup is true)"
}
