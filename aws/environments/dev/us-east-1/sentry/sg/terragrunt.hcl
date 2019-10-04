terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "terraform-aws-modules"
  repo_name = "terraform-aws-security-group"
  repo_version = "master"
  repo_path = ""
  local_source = false

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

inputs = {
  name = "sentry"
  description = "Security group for sentry asg"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
//    grpc rules overlayed by another module
//    TODO: REMOVE THIS
    {
      from_port   = 7100
      to_port     = 7100
      protocol    = "tcp"
      description = "grpc ingress"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "grpc ingress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

