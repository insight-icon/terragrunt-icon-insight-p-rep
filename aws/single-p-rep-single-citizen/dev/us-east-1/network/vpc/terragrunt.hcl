terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
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

  cidr = "10.0.0.0/16"
  // Running P-Rep in 1b - smaller subnet with one bastion
  private_subnets = [
    "10.0.0.0/24",
    "10.0.1.0/28",
    "10.0.2.0/24"]
  public_subnets = [
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24"]
}

