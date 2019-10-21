terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-nlb"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  domain_name = local.account_vars["domain_name"]
}

dependency "eip" {
  config_path = "../nlb-eip"
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "sentry_asg" {
  config_path = "../../sentry/asg"
}

dependency "lb_logging_bucket" {
  config_path = "../../logging/lb-logging-bucket"
}

inputs = {
  name = "prep-nlb"

  domain_name = local.domain_name

  log_bucket_name = dependency.lb_logging_bucket.outputs.bucket
  log_location_prefix = "nlb"

  public_subnets = dependency.vpc.outputs.public_subnets
  vpc_id = dependency.vpc.outputs.vpc_id

  eip_id = dependency.eip.outputs.eip_id

  sentry_autoscaling_group_id = dependency.sentry_asg.outputs.this_autoscaling_group_id
  citizen_autoscaling_group_id = dependency.sentry_asg.outputs.this_autoscaling_group_id # TODO: FIX

  tags = {}
}
