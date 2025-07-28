# oci-oke module
# Define OCI resources for oci-oke here
resource "oci_containerengine_cluster" "this" {
  compartment_id      = var.compartment_ocid
  name                = var.name
  vcn_id              = var.vcn_id
  kubernetes_version  = var.kubernetes_version

  endpoint_config {
    is_public_ip_enabled = true
  }

  options {
    add_ons {
      is_kubernetes_dashboard_enabled = false
      is_tiller_enabled               = false
    }

    kubernetes_network_config {
      pods_cidr     = var.pods_cidr
      services_cidr = var.services_cidr
    }

    service_lb_subnet_ids = var.lb_subnet_ids
  }
}
