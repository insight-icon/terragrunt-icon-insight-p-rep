terraform {
//  source = "github.com/robc-io/terraform-aws-icon-iam//node.git?ref=v0.0.1"
//  source = "github.com/robc-io/terraform-aws-icon-iam.git//node"
  source = "../../../../../modules/terraform-aws-icon-node-iam"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "Citizen"
}

