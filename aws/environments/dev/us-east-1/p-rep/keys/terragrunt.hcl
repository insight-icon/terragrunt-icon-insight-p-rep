terraform {
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=0.1.0"
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-p-rep-keys"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "p-rep"

  //  TODO: Fix this
  tags = {}
}
