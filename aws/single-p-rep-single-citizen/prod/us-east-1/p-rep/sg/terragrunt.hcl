//TODO Replace with official security group module - make sure rules are added as resources, not inline with sg group
//Becuase changes in SG force new resource in dependencies
terraform {
//  source = "github.com/robc-io/terraform-aws-icon-p-rep-sg.git?ref=0.0.1"
  source = "github.com/robc-io/terraform-aws-icon-p-rep-sg.git"
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