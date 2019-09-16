//TODO Replace with official security group module - make sure rules are added as resources, not inline with sg group
//Becuase changes in SG force new resource in dependencies
terraform {
//  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=0.1.0"
  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
//  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "robc-io"
  repo_name = "terraform-aws-icon-p-rep-sg"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

inputs = {
  name = "p-rep"
  group = "mainnet"
  vpc_id = dependency.vpc.outputs.vpc_id
  resource_group = "" # TODO RM

//  TODO: Fix this
  tags = {}
}