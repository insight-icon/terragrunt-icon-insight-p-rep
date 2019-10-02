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

dependency "vpc_svc" {
  config_path = "../vpc-services"
}

inputs = {
  name = "mgmt-vpc-peering"
  acceptor_vpc_id = dependency.vpc.outputs.vpc_id
  acceptor_route_table_id = dependency.vpc.outputs.vpc_main_route_table_id
  acceptor_vpc_cidr_block = dependency.vpc.outputs.vpc_cidr_block
  acceptor_pub_route_table_id = join(", ", dependency.vpc.outputs.public_route_table_ids)


  requestor_vpc_id = dependency.vpc_svc.outputs.vpc_id
  requestor_route_table_id = dependency.vpc_svc.outputs.vpc_main_route_table_id
  requestor_vpc_cidr_block = dependency.vpc_svc.outputs.vpc_cidr_block
  requestor_pub_route_table_id = join(", ", dependency.vpc_svc.outputs.public_route_table_ids)
}

