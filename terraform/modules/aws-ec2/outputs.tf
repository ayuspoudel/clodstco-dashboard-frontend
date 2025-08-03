output "instance_id" {
  value = aws_instance.this.id
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "root_volume_id" {
  value = aws_instance.this.root_block_device[0].volume_id
}


output "additional_volume_id" {
  value = try(aws_ebs_volume.additional[0].id, null)
}
