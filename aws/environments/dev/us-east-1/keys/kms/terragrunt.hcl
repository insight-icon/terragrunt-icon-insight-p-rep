terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "cloudposse"
  repo_name = "terraform-aws-kms-key"
  repo_version = "master"
  repo_path = ""
  local_source = false

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

inputs = {
  name = "consul-kms-key"
  description = "KMS key for consul"
  deletion_window_in_days = 28
  enable_key_rotation = true
  alias = "alias/parameter_store_key"
}

