terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-dns-setup"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "vpc_main" {
  config_path = "../../network/vpc-main"
}

dependency "vpc_mgmt" {
  config_path = "../../network/vpc-mgmt"
}

dependency "vpc_services" {
  config_path = "../../network/vpc-services"
}

dependency "vpc_support" {
  config_path = "../../network/vpc-support"
}

inputs = {
//  vpc_id = dependency.vpc_main.outputs.vpc_id
  vpc_ids = [dependency.vpc_main.outputs.vpc_id,
    dependency.vpc_mgmt.outputs.vpc_id,
    dependency.vpc_services.outputs.vpc_id,
    dependency.vpc_support.outputs.vpc_id]
}