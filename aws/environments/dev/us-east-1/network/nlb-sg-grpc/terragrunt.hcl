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
  config_path = "../vpc-main"
}

inputs = {
  name = "main"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      description = "rest ingress"
      cidr_blocks = "0.0.0.0/0"
    },
//    grpc rules overlayed by another module
//    TODO: REMOVE THIS
    {
      from_port   = 7100
      to_port     = 7100
      protocol    = "tcp"
      description = "grpc TEMPORARY ingress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

