terraform {
//  source = "github.com/cloudposse/terraform-aws-key-pair.git?ref=0.4.0"
//  source = "github.com/robc-io/terraform-aws-icon-p-rep-keys.git"
  source = "../../../../../modules/terraform-aws-icon-p-rep-keys"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "citizen"

  tags = {}
}
