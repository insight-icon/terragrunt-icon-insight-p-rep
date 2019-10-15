terraform {
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=0.1.0"
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-nlb"
}

include {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../nlb-sg-grpc"
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "sentry_asg" {
  config_path = "../../sentry/asg"
}

//dependency "alb_p_rep_log_bucket" {
//  config_path = "../alb-p-rep-log-bucket"
//}

inputs = {
//  log_bucket_name = dependency.alb_p_rep_log_bucket.outputs.aws_logs_bucket
//  log_bucket_name = "p-rep-alb-logs-${get_aws_account_id()}"
//  log_location_prefix = "p-rep-alb-logs"

  name = "prep-nlb"
  //  security_groups = [dependency.sg.outputs.security_group_ids[0]]
  security_groups = [dependency.sg.outputs.this_security_group_id]
  public_subnets = dependency.vpc.outputs.public_subnets
  vpc_id = dependency.vpc.outputs.vpc_id

  sentry_autoscaling_group_id = dependency.sentry_asg.outputs.this_autoscaling_group_id
  citizen_autoscaling_group_id = dependency.sentry_asg.outputs.this_autoscaling_group_id # TODO: FIX

  tags = {}
}
