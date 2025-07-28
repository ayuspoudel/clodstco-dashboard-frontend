output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs (empty if HA is disabled)"
  value       = var.enable_ha ? aws_subnet.private[*].id : []
}

output "public_subnet_cidrs" {
  description = "List of public subnet CIDRs used"
  value       = aws_subnet.public[*].cidr_block
}

output "private_subnet_cidrs" {
  description = "List of private subnet CIDRs used (empty if HA is disabled)"
  value       = var.enable_ha ? aws_subnet.private[*].cidr_block : []
}

output "nat_gateway_id" {
  description = "NAT Gateway ID (only if HA is enabled)"
  value       = var.enable_ha && length(aws_nat_gateway.this) > 0 ? aws_nat_gateway.this[0].id : null
}

output "availability_zones_used" {
  description = "List of AZs used (matched with subnets)"
  value       = slice(var.availability_zones, 0, var.enable_ha ? length(var.availability_zones) : 1)
}

output "public_route_table_id" {
  description = "Route table ID for public subnets"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "Route table ID for private subnets (null if HA is disabled)"
  value       = var.enable_ha ? aws_route_table.private[0].id : null
}
