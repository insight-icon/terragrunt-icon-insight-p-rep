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

inputs = {
  name = "citizen"
  vpc_id = dependency.vpc.outputs.vpc_id

  tags = {}
}