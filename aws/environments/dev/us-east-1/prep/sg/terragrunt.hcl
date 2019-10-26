//TODO Replace with official security group module - make sure rules are added as resources, not inline with sg group
//Becuase changes in SG force new resource in dependencies
terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-p-rep-sg"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  environment_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml")}"))
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "mgmt_vpc" {
  config_path = "../../network/vpc-mgmt"
}

// Only works when SGs are in same VPC
dependency "bastion_sg" {
  config_path = "../../bastion/sg"
}

//dependency "bastion_cidr" {
//  config_path = "../../network/vpc-mgmt"
//}

dependency "sentry_sg" {
  config_path = "../../sentry/sg"
}

inputs = {
  name = "prep"
  environment = local.environment_vars["environment"]

//  corporate_ip = local.account_vars["corporate_ip"]

  vpc_id = dependency.vpc.outputs.vpc_id

  bastion_security_group = dependency.bastion_sg.outputs.this_security_group_id

//  mgmt_vpc_id = dependency.mgmt_vpc.outputs.vpc_id

  tags = {}
}
