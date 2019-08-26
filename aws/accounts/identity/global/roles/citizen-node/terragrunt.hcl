terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role?ref=v2.3.0"
}

include {
  path = find_in_parent_folders()
}


inputs = {
  name = "citizen-node"
}
