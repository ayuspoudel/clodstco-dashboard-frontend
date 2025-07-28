# oci-oke

This module provisions an Oracle Kubernetes Engine (OKE) control plane.

## Inputs

- `name`: Cluster name
- `compartment_ocid`: OCI compartment OCID
- `vcn_id`: OCID of the Virtual Cloud Network
- `kubernetes_version`: Kubernetes version (default: v1.28.2)
- `pods_cidr`: CIDR block for pods
- `services_cidr`: CIDR block for services
- `lb_subnet_ids`: List of subnet IDs for OCI Load Balancer

## Outputs

- `cluster_id`: OKE cluster OCID
- `cluster_endpoint`: Public Kubernetes API server

## Usage

```hcl
module "oci_oke" {
  source            = "../modules/oci-oke"
  name              = "clodstco-oke"
  compartment_ocid  = var.compartment_ocid
  vcn_id            = module.oci_vcn.vcn_id
  lb_subnet_ids     = [module.oci_vcn.public_subnet_id]
}
```