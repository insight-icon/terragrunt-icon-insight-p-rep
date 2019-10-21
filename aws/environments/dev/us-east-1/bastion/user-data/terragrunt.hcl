terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-user-data"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "s3" {
  config_path = "../keys-bucket"
}

inputs = {
  type = "bastion_s3"

  s3_bucket_name = dependency.s3.outputs.this_s3_bucket_id
  ssh_user = "ubuntu"
  keys_update_frequency = "5,20,35,50 * * * *"
}

