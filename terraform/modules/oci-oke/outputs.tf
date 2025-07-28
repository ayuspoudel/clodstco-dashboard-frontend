# Output values for oci-oke module
output "cluster_id" {
  description = "The OCID of the OKE cluster"
  value       = oci_containerengine_cluster.this.id
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = oci_containerengine_cluster.this.endpoints[0].kubernetes
}
