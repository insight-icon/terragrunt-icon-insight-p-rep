terraform {
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=0.1.0"
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git//node"
  source = "../../../../../modules/${local.repo_name}//node"
}

// TODO ^^^ Be careful of folder ref

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-iam"
}

//terraform {
////  source = "github.com/robc-io/terraform-aws-icon-iam//node.git?ref=v0.0.1"
////  source = "github.com/robc-io/terraform-aws-icon-iam.git//node"
//  source = "../../../../../modules/"
//}

dependency "log_config_bucket" {
  config_path = "../../../us-east-1/logging/log-config-bucket"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "Citizen"

  log_bucket = dependency.log_config_bucket.outputs.log_config_bucket
}

