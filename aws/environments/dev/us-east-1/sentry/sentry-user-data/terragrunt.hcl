terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

dependency "ec2" {
  config_path = "../p-rep/ec2"
}

inputs = {
  name = "p-rep"
  p_rep_ip = dependency.ec2.outputs.private_ip
}
