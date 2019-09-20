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
  config_path = "../../network/vpc-logging"
}

dependency "vpc_mgmt" {
  config_path = "../../network/vpc-mgmt"
}

inputs = {
  name = "elasticsearch"
  description = "Security group for elasticsearch"
  vpc_id = dependency.vpc.outputs.vpc_id

  ingress_cidr_blocks = dependency.vpc.outputs.private_subnets_cidr_blocks
  ingress_rules = [
    "https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      description = "Restircited to management vpc cidr blocks"
      cidr_blocks = dependency.vpc_mgmt.outputs.private_subnets_cidr_blocks[0]
    }
  ]
  tags = {}
}