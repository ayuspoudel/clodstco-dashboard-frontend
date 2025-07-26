iam module for clodstco project

creates:
- iam role with trust policy
- attaches inline and managed policies
- supports irsa trust for eks service accounts

inputs:
- name: name of the role
- assume_role_policy: trust policy json
- inline_policies: list of policy objects
- managed_policy_arns: list of managed policy arns
- oidc_provider_arn: for irsa trust (optional)
- oidc_provider_url: for irsa trust (optional)
- namespace: k8s namespace for irsa (optional)
- service_account: k8s sa name for irsa (optional)
- tags: map of tags

outputs:
- role_name
- role_arn

use (ecs role):
module "s3_access_role" {
  source              = "../modules/iam"
  name                = "clodstco-s3-role"
  assume_role_policy  = data.aws_iam_policy_document.assume_ecs.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
  tags                = local.tags
}

data "aws_iam_policy_document" "assume_ecs" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

use (irsa):
module "irsa_cloudwatch" {
  source              = "../modules/iam"
  name                = "clodstco-irsa-metrics"
  oidc_provider_arn   = module.eks.oidc_provider_arn
  oidc_provider_url   = module.eks.oidc_provider_url
  namespace           = "monitoring"
  service_account     = "metrics-sa"
  managed_policy_arns = ["arn:aws:iam::aws:policy/CloudWatchFullAccess"]
  tags                = local.tags
}
