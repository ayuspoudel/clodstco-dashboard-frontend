# oci-sg

Creates a Security List in Oracle Cloud Infrastructure, similar to AWS Security Groups.

## Inputs

- `name`: Name for the security list
- `compartment_ocid`: OCI Compartment OCID
- `vcn_id`: VCN OCID
- `ingress_rules`: List of ingress rule objects
- `egress_rules`: Optional list of egress rule objects (default allows all)

## Outputs

- `security_list_id`: The ID of the created security list

## Usage

```hcl
module "oci_sg" {
  source           = "../modules/oci-sg"
  name             = "clodstco-instance-sg"
  compartment_ocid = var.compartment_ocid
  vcn_id           = module.oci_vcn.vcn_id

  ingress_rules = [
    {
      protocol   = "6" # TCP
      source     = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
      description = "Allow SSH"
    }
  ]
}
```