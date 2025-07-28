# oci-instance

Provisions an OCI compute instance (Always Free eligible).

## Inputs

- `name`: Name of the instance
- `compartment_ocid`: OCI compartment OCID
- `tenancy_ocid`: OCI tenancy OCID (for AD lookup)
- `subnet_id`: Target subnet ID
- `ssh_public_key`: SSH key to allow access
- `shape`: Instance shape (default: Always Free)
- `source_dest_check`: Disable if instance acts as NAT

## Outputs

- `instance_id`: ID of the compute instance
- `public_ip`: Public IPv4 address
- `private_ip`: Private IPv4 address

## Usage

```hcl
module "oci_instance" {
  source            = "../modules/oci-instance"
  name              = "clodstco-vm"
  compartment_ocid  = var.compartment_ocid
  tenancy_ocid      = var.tenancy_ocid
  subnet_id         = module.oci_vcn.public_subnet_id
  ssh_public_key    = file("~/.ssh/id_rsa.pub")
  source_dest_check = true
}
```
