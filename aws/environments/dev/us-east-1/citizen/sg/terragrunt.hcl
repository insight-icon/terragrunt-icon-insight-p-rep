terraform {
  //  source = "github.com/robc-io/terraform-aws-icon-p-rep-sg.git?ref=0.0.1"
//  source = "github.com/robc-io/terraform-aws-icon-p-rep-sg.git"
  source = "../../../../../modules/terraform-aws-icon-citizen-sg"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "bastionsg" {
  config_path = "../../bastion/sg"
}

inputs = {
  name = "citizen"
  vpc_id = dependency.vpc.outputs.vpc_id
  bastion_security_group = dependency.bastionsg.outputs.this_security_group_id

  tags = {}
}
