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
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "sg" {
  config_path = "../../p-rep/sg"
}

inputs = {
  name = "RhizomeIconNodeMonitor"

  security_group_ids = dependency.sg.outputs.security_group_ids
  subnet_ids = dependency.vpc.outputs.public_subnets

  api_endpoint = ""
  slack_api_token = ""
  slack_channel_id = ""
  tg_bot_token = ""
  tg_chat_id = ""

  //  TODO: Fix this
  tags = {}
}