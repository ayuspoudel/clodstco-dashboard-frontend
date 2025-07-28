# oci-vcn

This module creates a basic Virtual Cloud Network (VCN) and a single public subnet in Oracle Cloud Infrastructure.

## Inputs

- `name` - Name prefix for resources
- `compartment_ocid` - OCID of the compartment
- `vcn_cidr` - VCN CIDR block
- `public_subnet_cidr` - Subnet CIDR block

## Outputs

- `vcn_id` - The OCID of the VCN
- `public_subnet_id` - The OCID of the public subnet

## Usage

```hcl
module "oci_vcn" {
  source              = "../modules/oci-vcn"
  name                = "clodstco"
  compartment_ocid    = var.compartment_ocid
  vcn_cidr            = "10.10.0.0/16"
  public_subnet_cidr  = "10.10.1.0/24"
}
```
