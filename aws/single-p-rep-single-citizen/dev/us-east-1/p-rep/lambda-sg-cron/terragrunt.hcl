terraform {
//  source = "github.com/robcxyz/terraform-aws-icon-lambda-whitelist-cron.git?ref=0.0.1"
//  source = "github.com/robcxyz/terraform-aws-icon-lambda-whitelist-cron.git"
  source = "../../../../../modules/terraform-aws-icon-lambda-whitelist-cron"
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

  terraform_state_bucket = "terraform-states-057637264858"
}