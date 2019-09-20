terraform {
  source = "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
////  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
////  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-iam"
  repo_version = "v0.2.0"
  repo_path = "bastion"
}

include {
  path = find_in_parent_folders()
}

dependency "s3" {
  config_path = "../../../us-east-1/bastion/keys-bucket"
}

inputs = {
  name = "bastion"
  bucket = dependency.s3.outputs.this_s3_bucket_id
}

