terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = ""
  repo_name = "icon-node-monitor"
  repo_version = "master"
  repo_path = "terraform"
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}//${local.repo_path}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))

  slack_api_token = local.account_vars["slack_api_token"]
  slack_channel_id = local.account_vars["slack_channel_id"]
  tg_bot_token = local.account_vars["tg_bot_token"]
  tg_chat_id = local.account_vars["tg_chat_id"]
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "sg" {
  config_path = "../../p-rep/sg"
}

dependency "dns" {
  config_path = "../../p-rep/dns-c1"
}

inputs = {
  name = "RhizomeIconNodeMonitor"

  security_group_ids = dependency.sg.outputs.security_group_ids
  subnet_ids = dependency.vpc.outputs.public_subnets

  api_endpoint = join(":", [
    dependency.dns.outputs.fqdn,
    9000])

  slack_api_token = local.slack_api_token
  slack_channel_id = local.slack_channel_id
  tg_bot_token = local.tg_bot_token
  tg_chat_id = local.tg_chat_id

  //  TODO: Fix this
  tags = {}
}