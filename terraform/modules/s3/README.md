s3 module for clodstco project

creates:
- s3 bucket with encryption, versioning (optional), and private acl

inputs:
- name: name of the bucket
- enable_versioning: bool, default false
- force_destroy: bool, default false
- tags: map of tags

outputs:
- bucket_name
- bucket_arn

use:
module "logs_bucket" {
  source            = "../modules/s3"
  name              = "clodstco-logs"
  enable_versioning = true
  force_destroy     = false
  tags              = local.tags
}
