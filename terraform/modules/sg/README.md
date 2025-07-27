
## sg module for clodstco project

creates:

* security group with dynamic ingress and egress rules

inputs:

* name: name of the sg
* description: description of the sg
* vpc\_id: id of the vpc
* ingress\_rules: list of ingress rule objects
* egress\_rules: list of egress rule objects (optional, defaults to allow all)
* tags: map of tags

outputs:

* security\_group\_id

rule object:

* description: optional
* from\_port: required
* to\_port: required
* protocol: required
* cidr\_blocks: optional
* ipv6\_cidr\_blocks: optional
* prefix\_list\_ids: optional

use:

```hcl
module "rds_sg" {
  source      = "../modules/sg"
  name        = "rds-sg"
  description = "allow db access"
  vpc_id      = module.vpc.vpc_id
  tags        = local.tags

  ingress_rules = [
    {
      description = "postgres from internal"
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}
```

