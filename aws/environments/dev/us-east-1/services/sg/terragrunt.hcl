terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group.git?ref=v3.1.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = "bastion-sg"
  description = "Security group for support cluster only allowing http(s) / ssh access from bastion"

  common_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("common_vars.yaml")}"))
  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))

  coporate_ip = local.account_vars["corporate_ip"]
}

dependency "vpc" {
  config_path = "../../network/vpc-mgmt"
}

dependency "bastion" {
  config_path = "../../bastion/vpc-mgmt"
}

inputs = {
  name = local.name

  description = local.description
  vpc_id = dependency.vpc.outputs.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule = "ssh-tcp"
      source_security_group_id = dependency.bastion.outputs.this_security_group_id
    },
    {
      rule = "https-tcp"
      source_security_group_id = dependency.bastion.outputs.this_security_group_id
    },
    {
      rule = "http-tcp"
      source_security_group_id = dependency.bastion.outputs.this_security_group_id
    }
  ]

//  ingress_with_cidr_blocks = [
//    {
//      from_port = 443
//      to_port = 443
//      protocol = "tcp"
//      description = "SSH ingress access from coporate ip only"
//      cidr_blocks = "${local.coporate_ip}/32"
//    }
//  ]

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
