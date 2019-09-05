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
}