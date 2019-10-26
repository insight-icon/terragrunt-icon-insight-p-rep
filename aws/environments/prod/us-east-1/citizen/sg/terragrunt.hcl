terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "terraform-aws-modules"
  repo_name = "terraform-aws-security-group"
  repo_version = "master"
  repo_path = ""
  local_source = false

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

inputs = {
  name = "consul"
  description = "Security group for consul agents"
  vpc_id = dependency.vpc.outputs.vpc_id

  number_of_computed_ingress_with_self = 3

  computed_ingress_with_self = [
    {
      rule = "consul-serf-lan-tcp"
      source_security_group_id = "self"
    },
    {
      rule = "consul-dns-tcp"
      source_security_group_id = "self"
    },
    {
      rule = "consul-dns-udp"
      source_security_group_id = "self"
    }
  ]


//  egress_cidr_blocks = ["0.0.0.0/0"]
}

