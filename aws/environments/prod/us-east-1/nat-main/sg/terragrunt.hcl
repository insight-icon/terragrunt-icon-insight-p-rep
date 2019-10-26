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
  config_path = "../../network/vpc-main"
}

dependency "bastion_sg" {
  config_path = "../../bastion/sg"
}

inputs = {
  name = "nat"
  description = "Security group for sentry asg"
  vpc_id = dependency.vpc.outputs.vpc_id

  ingress_with_cidr_blocks = [
    //    TODO: Fix to EIP of NLB + bastion host
    {
      from_port = 7100
      to_port = 7100
      protocol = "tcp"
      description = "grpc ingress"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 9000
      to_port = 9000
      protocol = "tcp"
      description = "grpc ingress"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port = 0
      to_port = 65535
      protocol = -1
      description = "Egress access open to all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 3

  computed_ingress_with_source_security_group_id = [
    {
      rule = "ssh-tcp"
      source_security_group_id = dependency.bastion_sg.outputs.this_security_group_id
    },
    {
      rule = "consul-dns-tcp"
      source_security_group_id = dependency.bastion_sg.outputs.this_security_group_id
    },
    {
      rule = "consul-dns-udp"
      source_security_group_id = dependency.bastion_sg.outputs.this_security_group_id
    }
  ]


//  egress_cidr_blocks = ["0.0.0.0/0"]
}

