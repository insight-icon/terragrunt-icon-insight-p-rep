terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "dns" {
  config_path = "../../network/dns"
}

dependency "ec2" {
  config_path = "../ec2"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  hostname = "prep"
  private_ip = dependency.ec2.outputs.private_ip

  zone_id = dependency.dns.outputs.private_zone_id

  //  TODO: Fix this
  tags = {}
}
