terraform {
  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=v5.1.0"
  //  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
  //  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "terraform-aws-modules"
  repo_name = "terraform-aws-eks"
}


include {
  path = find_in_parent_folders()
}

//dependency "iam" {
//  config_path = "../../../global/profiles/p-rep"
//}

dependency "vpc" {
  config_path = "../../network/vpc"
}

//dependency "sg" {
//  config_path = "../sg"
//}
//
//dependency "keys" {
//  config_path = "../keys"
//}
//
//dependency "log_config" {
//  config_path = "../../logging/log-config-bucket"
//}

inputs = {
  cluster_name = "my-cluster"
  subnets = dependency.vpc.outputs.public_subnets
  vpc_id = dependency.vpc.outputs.vpc_id

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size = 2
      tags = [
        {
          key = "foo"
          value = "bar"
          propagate_at_launch = true
        }]
    }
  ]

  tags = {
    environment = "test"
  }

//  name = "node"
//  group = "mainnet"
//
//  volume_dir = ""
//  ebs_volume_size = 100
//  root_volume_size = "20"
//  instance_type = "m4.large"
//  volume_path = "/dev/sdf"
//
//  key_name = dependency.keys.outputs.key_name
//  public_key = dependency.keys.outputs.public_key
//
//  security_groups = dependency.sg.outputs.security_group_ids
//  subnet_id = dependency.vpc.outputs.public_subnets[0]

//  instance_profile_id = dependency.iam.outputs.instance_profile_id
//
//  log_config_bucket = dependency.log_config.outputs.log_config_bucket
//  log_config_key = dependency.log_config.outputs.log_config_key
//
}