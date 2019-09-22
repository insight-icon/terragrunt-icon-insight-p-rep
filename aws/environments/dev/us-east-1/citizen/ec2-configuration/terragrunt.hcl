terraform {
  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=v0.0.1"
//  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "anocendi"
  repo_name = "terraform-aws-icon-node-configuration"
}


include {
  path = find_in_parent_folders()
}

dependency "citizen_ec2" {
  config_path = "../ec2"
}

inputs = {
  name = "citizen-node-configuration"
  eip = dependency.citizen_ec2.outputs.public_ip

  //TODO: Will fix this if I need to provide tags
  tags = {}
}
