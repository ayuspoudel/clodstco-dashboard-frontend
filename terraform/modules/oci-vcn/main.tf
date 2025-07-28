resource "oci_core_virtual_network" "this" {
  cidr_block     = var.vcn_cidr
  display_name   = "${var.name}-vcn"
  compartment_id = var.compartment_ocid
  freeform_tags  = var.tags
}

resource "oci_core_subnet" "public" {
  cidr_block                 = var.public_subnet_cidr
  display_name               = "${var.name}-public-subnet"
  compartment_id             = var.compartment_ocid
  vcn_id                     = oci_core_virtual_network.this.id
  route_table_id             = oci_core_virtual_network.this.default_route_table_id
  security_list_ids          = [oci_core_virtual_network.this.default_security_list_id]
  dhcp_options_id            = oci_core_virtual_network.this.default_dhcp_options_id
  prohibit_public_ip_on_vnic = false
  freeform_tags              = var.tags
}
