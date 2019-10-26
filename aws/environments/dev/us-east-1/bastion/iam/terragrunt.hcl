terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-iam"
  repo_version = "v0.2.0"
  repo_path = "bastion"
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  environment_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml")}"))
}

dependency "s3" {
  config_path = "../keys-bucket"
}

inputs = {
  name = "bastion"
  bucket = dependency.s3.outputs.this_s3_bucket_id

  environment = local.environment_vars["environment"]

//  TODO Set default in global setting
  tags = {}
}

