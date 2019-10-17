terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
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

