terraform {
  source = "github.com/cloudposse/terraform-aws-cloudtrail-s3-bucket.git"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "audit-cloudtrail-${get_aws_account_id()}"
  region = "us-east-1"
  force_destroy = true

// TODO consider keeping some of this
  namespace = "cp"
  stage     = "prod"
}


