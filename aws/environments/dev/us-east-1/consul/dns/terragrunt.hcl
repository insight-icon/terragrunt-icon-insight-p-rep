terraform {
  source = "../../../../../modules/terraform-aws-icon-consul-dns"
}

include {
  path = find_in_parent_folders()
}

dependency "dns-zone" {
  config_path = "../../network/dns"
}

dependency "main-vpc" {
  config_path = "../../network/vpc"
}

dependency "svc-vpc" {
  config_path = "../../network/vpc-services"
}

inputs = {
  zone_id = dependency.dns-zone.outputs.zone_id
  main_vpc_id = dependency.main-vpc.outputs.vpc_id
  service_vpc_id = dependency.svc-vpc.outputs.vpc_id
}