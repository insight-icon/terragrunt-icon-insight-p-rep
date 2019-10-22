terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "cloudposse"
  repo_name = "terraform-aws-ecr"
  repo_version = "master"
  repo_path = ""
  local_source = false
  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

// TODO: Build iam roles
//dependency "iam" {
//  config_path = "../../../global/<>"
//}

inputs = {
  namespace = "insight.services"
  name = "ecr"
//  principals_full_access = [
//    data.aws_iam_role.ecr.arn]

//  tags = {
//    environment = "test"
//  }
}