provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

locals {
  tags = {
    project     = "clodstco"
    environment = "dev"
    owner       = "ayuspoudel"
  }
}

module "oci_vcn" {
  source                = "../modules/oci-vcn"
  name                  = "clodstco-vcn"
  compartment_ocid      = var.compartment_ocid
  vcn_cidr              = "10.10.0.0/16"
  public_subnet_cidr    = "10.10.1.0/24"
  tags                  = local.tags
}


module "oci_sg" {
  source           = "../modules/oci-sg"
  name             = "oke-lb-sg"
  compartment_ocid = var.compartment_ocid
  vcn_id           = module.oci_vcn.vcn_id
  tags             = local.tags

  ingress_rules = [
    {
      protocol    = "6"
      source      = "0.0.0.0/0"
      from_port   = 6443
      to_port     = 6443
      description = "Kubernetes API"
    },
    {
      protocol    = "6"
      source      = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      description = "HTTP for LB"
    },
    {
      protocol    = "6"
      source      = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
      description = "HTTPS for LB"
    }
  ]
}

module "oci_oke" {
  source            = "../modules/oci-oke"
  name              = "clodstco-oke"
  compartment_ocid  = var.compartment_ocid
  vcn_id            = module.oci_vcn.vcn_id
  lb_subnet_ids     = [module.oci_vcn.public_subnet_id]
}
