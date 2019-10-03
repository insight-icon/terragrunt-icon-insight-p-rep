terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-lambda-whitelist-cron"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

// Note, this is for whatever front facing EIP
dependency "sg" {
  config_path = "../../network/nlb-sg-grpc"
}

inputs = {
  name = "lambda-sg-cron"
  group = "network"
  module = "nlb-sg"

//  TODO FIX
  grpc_security_group_id = dependency.sg.outputs.this_security_group_id
  security_group_ids = [dependency.sg.outputs.this_security_group_id]

  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets

  terraform_state_bucket = "terraform-states-${get_aws_account_id()}"
  lock_table = "terraform-locks-${get_aws_account_id()}"
  key = format("%s/lambda-sg/sterraform.tfstate", path_relative_to_include())
  sg_name = "lambda-sg-cron-sg"
}