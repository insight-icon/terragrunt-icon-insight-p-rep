terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "support-vpc"

  enable_nat_gateway = false
  //  single_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support = true

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"]

  cidr = "172.24.0.0/16"

  public_subnets = [
    "172.24.0.0/24",
    "172.24.1.0/24",
    "172.24.2.0/24"]

  private_subnets = [
    "172.24.100.0/24",
    "172.24.101.0/24",
    "172.24.102.0/24"]

  database_subnets = [
    "172.24.200.0/24",
    "172.24.201.0/24",
    "172.24.202.0/24"]
}

