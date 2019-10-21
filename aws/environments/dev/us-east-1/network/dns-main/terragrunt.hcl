terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

locals {
  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  private_tld = local.account_vars["private_tld"]
}

dependency "vpc_main" {
  config_path = "../vpc-main"
}

dependency "dns" {
  config_path = "../dns"
}

inputs = {
  vpc_id = dependency.vpc_main.outputs.vpc_id

  private_zone_id = dependency.dns.outputs.private_zone_id
}