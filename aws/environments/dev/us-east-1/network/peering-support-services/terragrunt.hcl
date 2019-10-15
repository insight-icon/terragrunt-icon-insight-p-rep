terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-peering"
  repo_version = "master"
  repo_path = ""
  local_source = false

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "vpc" {
  config_path = "../vpc-support"
}

dependency "vpc_peer" {
  config_path = "../vpc-services"
}

inputs = {
  name = "support-services-vpc-peering"
  acceptor_vpc_id = dependency.vpc.outputs.vpc_id

  requestor_vpc_id = dependency.vpc_peer.outputs.vpc_id
}

