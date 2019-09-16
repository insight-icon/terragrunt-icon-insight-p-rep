terraform {
//  source = "github.com/robc-io/terraform-aws-icon-iam//bastion.git?ref=v0.0.1"
  source = "github.com/robc-io/terraform-aws-icon-iam.git//logging"
//  source = "../../../../../modules/terraform-aws-icon-node-iam"
}

include {
  path = find_in_parent_folders()
}

dependency "s3" {
  config_path = "../../../us-east-1/bastion/keys-bucket"
}

inputs = {
  name = "Citizen"
  bucket = dependency.s3.outputs.this_s3_bucket_id
}

