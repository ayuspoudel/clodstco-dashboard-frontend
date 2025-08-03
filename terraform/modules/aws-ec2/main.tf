resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  source_dest_check           = var.source_dest_check
  user_data                   = var.user_data
  associate_public_ip_address = var.associate_public_ip

  # Spot instance support
  dynamic "instance_market_options" {
    for_each = var.spot_instance ? [1] : []
    content {
      market_type = "spot"
    }
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )
}

# Root EBS volume (external)
resource "aws_ebs_volume" "root" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type
  tags              = merge(var.tags, { Name = "${var.name}-root" })
}

resource "aws_volume_attachment" "root_attach" {
  device_name = var.root_device_name
  volume_id   = aws_ebs_volume.root.id
  instance_id = aws_instance.this.id
  force_detach = true
}

# Additional EBS volume (optional)
resource "aws_ebs_volume" "additional" {
  count             = var.additional_ebs_volume != null ? 1 : 0
  availability_zone = var.availability_zone
  size              = var.additional_ebs_volume.volume_size
  type              = var.additional_ebs_volume.volume_type
  tags              = merge(var.tags, { Name = "${var.name}-data" })
}

resource "aws_volume_attachment" "additional_attach" {
  count       = var.additional_ebs_volume != null ? 1 : 0
  device_name = var.additional_ebs_volume.device_name
  volume_id   = aws_ebs_volume.additional[0].id
  instance_id = aws_instance.this.id
  force_detach = true
}
