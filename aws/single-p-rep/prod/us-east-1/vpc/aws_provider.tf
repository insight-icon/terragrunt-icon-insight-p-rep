provider "aws" {
  version = "~> 3.0"

  region              = var.aws_region
  allowed_account_ids = var.aws_allowed_account_ids

  # Make it faster by skipping some things
  skip_get_ec2_platforms     = true
  skip_metadata_api_check    = true
  skip_region_validation     = true
  skip_requesting_account_id = true
}

terraform {
  backend "s3" {}
}
