terraform {
  //  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=0.1.0"
  //  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-peering-mgmt"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "vpc_mgmt" {
  config_path = "../vpc-mgmt"
}

inputs = {
  name = "mgmt-vpc-peering"
  acceptor_vpc_id = dependency.vpc.outputs.vpc_id
  acceptor_route_table_id = dependency.vpc.outputs.vpc_main_route_table_id
  acceptor_vpc_cidr_block = dependency.vpc.outputs.vpc_cidr_block

  requestor_vpc_id = dependency.vpc_mgmt.outputs.vpc_id
  requestor_route_table_id = dependency.vpc_mgmt.outputs.vpc_main_route_table_id
  requestor_vpc_cidr_block = dependency.vpc_mgmt.outputs.vpc_cidr_block
}

