terraform {
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=0.1.0"
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-lambda-whitelist-cron"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "sg" {
  config_path = "../sg"
}

inputs = {
  name = "lambda-sg-cron"
  group = "p-rep"

  security_group_ids = dependency.sg.outputs.security_group_ids
  subnet_ids = dependency.vpc.outputs.private_subnets

  terraform_state_bucket = "terraform-states-${get_aws_account_id()}"
  lock_table = "terraform-locks-${get_aws_account_id()}"
  key = format("%s/lambda-sg/terraform.tfstate", path_relative_to_include())
  sg_name = "lambda-sg-cron-sg"
}