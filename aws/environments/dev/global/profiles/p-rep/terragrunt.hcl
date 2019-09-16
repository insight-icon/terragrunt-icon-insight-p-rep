terraform {
//  source = "github.com/robc-io/terraform-aws-icon-node-iam.git?ref=v0.0.1"
//  source = "github.com/robc-io/terraform-aws-icon-node-iam.git"
  source = "../../../../../modules/terraform-aws-icon-node-iam"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "PRep"
}

