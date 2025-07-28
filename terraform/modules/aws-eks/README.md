eks module for clodstco project

creates:
- eks cluster control plane
- default managed node group
- oidc provider for irsa

inputs:
- name: cluster name
- subnet_ids: list of subnet ids (private recommended)
- security_group_ids: list of sg ids
- kubernetes_version: default 1.29
- node_instance_type: default t3.medium
- node_min_size: default 1
- node_max_size: default 3
- node_desired_size: default 2
- tags: map of tags

outputs:
- cluster_name
- cluster_endpoint
- cluster_arn
- cluster_certificate_authority
- oidc_provider_arn
- oidc_provider_url

use:
module "eks" {
  source              = "../modules/eks"
  name                = "clodstco"
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [module.eks_sg.security_group_id]
  tags                = local.tags
}
