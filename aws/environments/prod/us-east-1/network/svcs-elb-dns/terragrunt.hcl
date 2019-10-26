terraform {
  source = "github.com/shinyfoil/terraform-aws-icon-ingress-dns.git"
}

include {
  path = find_in_parent_folders()
}

locals {
  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  region_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("region.yaml")}"))
}

dependency "dns" {
  config_path = "../dns"
}

inputs = {
  zone_id = dependency.dns.outputs.public_zone_id
  root_domain_name = local.account_vars["domain_name"]
  region = local.region_vars["region"]
}