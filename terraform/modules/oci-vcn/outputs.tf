# Output values for oci-vcn module
output "vcn_id" {
  value = oci_core_virtual_network.this.id
}

output "public_subnet_id" {
  value = oci_core_subnet.public.id
}
