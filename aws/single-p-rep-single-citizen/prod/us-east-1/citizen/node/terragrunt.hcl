terraform {
//  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git?ref=0.0.1"
//  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git"
  source = "../../../../../modules/terraform-aws-icon-citizen-node"
}


include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "sg" {
  config_path = "../sg"
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
  ebs_volume_size = 100
  root_volume_size = "20"
  instance_type = "m4.large"
  volume_path = "/dev/sdf"

  key_name = dependency.keys.outputs.key_name
  public_key = dependency.keys.outputs.public_key

  security_groups = dependency.sg.outputs.security_group_ids
  subnet_id = dependency.vpc.outputs.public_subnets[0]
}