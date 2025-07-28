output "vcn_id" {
  description = "ID of the VCN"
  value       = oci_core_virtual_network.this.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = oci_core_subnet.public.id
}
