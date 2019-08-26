
terraform {
  source = "github.com/robc-io/terraform-aws-cloudfront-s3-acm"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = "vpc"
}

inputs = {
  enable_nat_gateway = "false"
  single_nat_gateway = "false"
  name = "main-net-vpc"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
}

