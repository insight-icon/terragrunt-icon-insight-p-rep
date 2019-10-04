terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "ec2" {
  config_path = "../ec2"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  hostname = "prep"
  private_ip = dependency.ec2.outputs.private_ip

  //  TODO: Fix this
  tags = {}
}
