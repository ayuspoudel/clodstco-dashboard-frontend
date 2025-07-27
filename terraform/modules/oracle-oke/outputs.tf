output "cluster_id" {
  value = oci_containerengine_cluster.this.id
}

output "kubeconfig_endpoint" {
  value = oci_containerengine_cluster.this.endpoints[0].public_endpoint
}
