terraform {
  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git?ref=0.0.1"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "keys" {
  config_path = "../keys"
}

inputs = {
  resource_group = "node"
  group = "mainnet"

  efs_directory = "/opt/data"
  resource_group = "ec2"
  volume_dir = ""
  root_volume_size = "20"
  instance_type = "m4.large"
  volume_path = "/dev/sdf"

  key_name = dependency.keys.outputs.key_name
  public_key = dependency.keys.outputs.public_key

  subnet_id = dependency.vpc.outputs.subnet_id
}