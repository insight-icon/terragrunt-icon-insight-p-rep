//terraform {
//  source = "${local.source}"
//}
//
//include {
//  path = find_in_parent_folders()
//}
//
//locals {
//  repo_owner = "insight-infrastructure"
//  repo_name = "terraform-aws-icon-node-dns"
//  repo_version = "master"
//  repo_path = ""
//  local_source = true
//
//  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
//
//  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
//  private_tld = local.account_vars["private_tld"]
//  public_zone_id = local.account_vars["zone_id"]
//  domain_name = local.account_vars["domain_name"]
//}
//
//dependency "nlb" {
//  config_path = "../nlb"
//}
//
//inputs = {
//  hostname = "nlb"
//
//  domain_name = local.domain_name
//  internal_domain_name = local.private_tld
//
//  public_ips = dependency.nlb.outputs.eips
//
//  tags = {}
//}