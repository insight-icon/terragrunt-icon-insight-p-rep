terraform {
  source = "github.com/robc-io/terraform-aws-icon-p-rep-sg.git?ref=0.0.1"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

inputs = {
  name = "sg-citizen"
  group = "mainnet"
  vpc_id = dependency.vpc.outputs.vpc_id
  resource_group = "" # TODO RM
}