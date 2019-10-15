terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "terraform-aws-modules"
  repo_name = "terraform-aws-eks"
  repo_version = "v5.1.0"

  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=${local.repo_version}"
}

//dependency "iam" {
//  config_path = "../iam"
//}

dependency "vpc" {
  config_path = "../../network/vpc-services"
}

//dependency "sg" {
//  config_path = "../sg"
//}

inputs = {
  cluster_name = "ServicesCluster"
  subnets = dependency.vpc.outputs.public_subnets
  vpc_id = dependency.vpc.outputs.vpc_id

//  cluster_security_group_id = dependency.sg.outputs.security_group_ids

  manage_worker_autoscaling_policy = true

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size = 2
      tags = [
        {
          key = "Name"
          value = "ServicesCluster"
          propagate_at_launch = true
        }
      ]
    }
  ]

  tags = {
    Environment = "Dev"
  }
}
