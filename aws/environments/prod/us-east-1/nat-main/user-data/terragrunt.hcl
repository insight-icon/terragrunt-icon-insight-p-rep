terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-user-data"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

//dependency "nlb" {
//  config_path = "../../nlb/nlb"
//}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

inputs = {
  type = "nat"
  nlb_dns = "nlb.us-east-1.icon.internal"
  consul_enabled = true
  prometheus_enabled = true

  vpc_cidr = dependency.vpc.outputs.default_vpc_cidr_block
}

