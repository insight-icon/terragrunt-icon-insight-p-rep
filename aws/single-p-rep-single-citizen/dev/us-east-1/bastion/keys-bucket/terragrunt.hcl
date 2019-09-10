
terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-s3-bucket"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = "vpc"
}

inputs = {
  bucket = "public-keys-${get_aws_account_id()}"
  acl    = "private"

  versioning = {
    enabled = true
  }
}

