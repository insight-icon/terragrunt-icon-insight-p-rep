//terraform {
//  source = "${local.source}"
//}

terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

//locals {
//  repo_owner = "insight-infrastructure"
//  repo_name = "terraform-aws-peering-main"
//  repo_version = "master"
//  repo_path = ""
//  local_source = true
//
//  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
//}

dependency "vpc_main" {
  config_path = "../vpc-main"
}

dependency "vpc_mgmt" {
  config_path = "../vpc-mgmt"
}

dependency "vpc_support" {
  config_path = "../vpc-support"
}

dependency "vpc_services" {
  config_path = "../vpc-services"
}

inputs = {
  name = "main-vpc-peering"

//  TODO Clean all dis
  ops_region = "us-east-1"

  main_vpc_id = dependency.vpc_main.outputs.vpc_id

  main_vpc_cidr_block = dependency.vpc_main.outputs.vpc_cidr_block

//  main_vpc_route_table_id = dependency.vpc_main.outputs.public_route_table_ids[0]
  main_vpc_route_table_id = dependency.vpc_main.outputs.vpc_main_route_table_id

  mgmt_vpc_id = dependency.vpc_mgmt.outputs.vpc_id
  mgmt_vpc_cidr_block = dependency.vpc_mgmt.outputs.vpc_cidr_block

//  mgmt_vpc_route_table_id = dependency.vpc_mgmt.outputs.public_route_table_ids[0]
  mgmt_vpc_route_table_id = dependency.vpc_mgmt.outputs.vpc_main_route_table_id

  services_vpc_id = dependency.vpc_services.outputs.vpc_id
  services_vpc_cidr_block = dependency.vpc_services.outputs.vpc_cidr_block

//  services_vpc_route_table_id = dependency.vpc_services.outputs.public_route_table_ids[0]
  services_vpc_route_table_id = dependency.vpc_services.outputs.vpc_main_route_table_id

  support_vpc_id = dependency.vpc_support.outputs.vpc_id
  support_vpc_cidr_block = dependency.vpc_support.outputs.vpc_cidr_block

//  support_vpc_route_table_id = dependency.vpc_support.outputs.public_route_table_ids[0]
  support_vpc_route_table_id = dependency.vpc_support.outputs.vpc_main_route_table_id
}

