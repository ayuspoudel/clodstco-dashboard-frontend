# oci-sg module
# Define OCI resources for oci-sg here
resource "oci_core_security_list" "this" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = var.name
  freeform_tags  = var.tags
  dynamic "ingress_security_rules" {
    for_each = var.ingress_rules
    content {
      protocol    = ingress_security_rules.value.protocol
      source      = ingress_security_rules.value.source
      description = lookup(ingress_security_rules.value, "description", null)
      tcp_options {
        min = ingress_security_rules.value.from_port
        max = ingress_security_rules.value.to_port
      }
    }
  }

  dynamic "egress_security_rules" {
    for_each = var.egress_rules != null ? var.egress_rules : [{
      protocol = "all"
      destination = "0.0.0.0/0"
    }]
    content {
      protocol     = egress_security_rules.value.protocol
      destination  = egress_security_rules.value.destination
      description  = lookup(egress_security_rules.value, "description", null)
    }
  }
}
