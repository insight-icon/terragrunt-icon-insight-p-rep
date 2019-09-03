
terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.9.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = "vpc"
}

inputs = {
  enable_nat_gateway = "true"
  single_nat_gateway = "true"
  name = "main-net-vpc"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"
}

