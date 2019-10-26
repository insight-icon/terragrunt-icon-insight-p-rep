terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.1.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = "bastion-sg"
  description = "Security group for bastion only allowing ssh access from coporate ip"

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  coporate_ip = local.account_vars["corporate_ip"]
}

dependency "vpc" {
  config_path = "../../network/vpc-mgmt"
}

inputs = {
  name = local.name

  description = local.description
  vpc_id = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      description = "SSH ingress access from coporate ip only"
      cidr_blocks = "${local.coporate_ip}/32"
    },
  ]

  computed_ingress_with_self = [
    {
      rule = "ssh-tcp"
      source_security_group_id = "self"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port = 65535
      protocol = -1
      description = "Egress access open to all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  // Tags will be filled in later as appropriate
  tags = {}
}
