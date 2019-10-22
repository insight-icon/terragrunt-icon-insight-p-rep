//TODO Replace with official security group module - make sure rules are added as resources, not inline with sg group
//Becuase changes in SG force new resource in dependencies
terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-p-rep-sg"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "bastionsg" {
  config_path = "../../bastion/sg"
}

inputs = {
  name = "p-rep"
  group = "mainnet"
  vpc_id = dependency.vpc.outputs.vpc_id
  bastion_security_group = dependency.bastionsg.outputs.this_security_group_id
  resource_group = "" # TODO RM

//  TODO: Fix this
  tags = {}
}
