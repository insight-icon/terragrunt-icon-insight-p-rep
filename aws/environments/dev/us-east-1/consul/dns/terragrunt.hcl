terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-consul-dns"
  repo_version = "master"
  repo_path = ""
  local_source = false

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "dns" {
  config_path = "../../network/dns"
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "vpc_services" {
  config_path = "../../network/vpc-services"
}

inputs = {
  main_vpc_id = dependency.vpc.outputs.vpc_id
  service_vpc_id = dependency.vpc_services.outputs.vpc_id

  zone_id = dependency.dns.outputs.private_zone_id
}
