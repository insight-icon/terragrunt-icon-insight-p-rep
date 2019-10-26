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

inputs = {
  type = "prep"
  ssh_user = "ubuntu"
  prometheus_enabled = true
  consul_enabled = true
  driver_type = "standard"
}

