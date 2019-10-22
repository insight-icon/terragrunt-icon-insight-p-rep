terraform {
  source = "github.com/shinyfoil/terraform-aws-icon-ingress-dns.git"
}

include {
  path = find_in_parent_folders()
}

locals {
  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
}

dependency "dns-zone" {
  config_path = "../dns"
}

inputs = {
  zone_id = dependency.dns-zone.outputs.zone_id
  root_domain_name = local.account_vars["domain_name"]
  region = "{$var.aws_region}"
}