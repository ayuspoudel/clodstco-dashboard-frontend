resource "oci_core_vcn" "vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_id
  display_name   = "${var.name}-vcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  enabled        = true
  display_name   = "${var.name}-igw"
}

resource "oci_core_route_table" "rt" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "${var.name}-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "public" {
  cidr_block        = var.public_subnet_cidr
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.vcn.id
  route_table_id    = oci_core_route_table.rt.id
  display_name      = "${var.name}-public-subnet"
  dns_label         = "pubsub"
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_subnet" "private" {
  cidr_block        = var.private_subnet_cidr
  compartment_id    = var.compartment_id
  vcn_id            = oci_core_vcn.vcn.id
  display_name      = "${var.name}-private-subnet"
  dns_label         = "prvsub"
  prohibit_public_ip_on_vnic = true
}

resource "oci_containerengine_cluster" "oke" {
  compartment_id     = var.compartment_id
  name               = var.name
  kubernetes_version = var.kubernetes_version
  vcn_id             = oci_core_vcn.vcn.id

  options {
    kubernetes_network_config {
      pods_cidr     = var.pods_cidr
      services_cidr = var.services_cidr
    }
  }

  endpoint_config {
    is_public_ip_enabled = var.enable_public_kube
    subnet_id            = oci_core_subnet.public.id
  }

  metadata = {
    "created-by" = "terraform"
  }
}

resource "oci_containerengine_node_pool" "node_pool" {
  compartment_id       = var.compartment_id
  cluster_id           = oci_containerengine_cluster.oke.id
  name                 = "${var.name}-np"
  kubernetes_version   = var.kubernetes_version
  node_shape           = var.node_shape
  subnet_ids           = [oci_core_subnet.private.id]

  node_config_details {
    size = var.node_count
    placement_configs {
      availability_domain = var.availability_domain
      subnet_id           = oci_core_subnet.private.id
    }
  }

  node_source_details {
    source_type = "IMAGE"
    image_id    = var.node_image_id
  }

  ssh_public_key = var.ssh_public_key
}
