## Oracle OKE Cluster Module

Provisions a basic OKE (Oracle Kubernetes Engine) cluster with a VCN, public and private subnets, and a single node pool.

### Inputs

- `compartment_id`: OCI compartment OCID
- `availability_domain`: AD to deploy the node pool
- `name`: Name prefix for all resources
- `node_image_id`: Image OCID for the node pool
- `ssh_public_key`: SSH key to access worker nodes
- `enable_public_kube`: Whether to expose the OKE endpoint publicly

### Outputs

- `cluster_id`
- `vcn_id`
- `public_subnet_id`
- `private_subnet_id`
- `kubeconfig_endpoint`
Example Usage
In your terraform/dev/main.tf:

```bash
module "oke" {
  source              = "../modules/oracle-oke"
  compartment_id      = var.oci_compartment_id
  availability_domain = var.oci_availability_domain
  name                = "clodstco"
  node_image_id       = var.oci_node_image_id
  ssh_public_key      = file("~/.ssh/id_rsa.pub")
}
```