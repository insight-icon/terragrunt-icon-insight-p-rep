terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  enable_nat_gateway = "false"

  name = "mgmt-vpc"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"]

  cidr = "172.28.0.0/16"

  private_subnets = [
    "172.28.100.0/24",
    "172.28.101.0/24",
    "172.28.102.0/24"]

  public_subnets = [
    "172.28.0.0/24",
    "172.28.1.0/24",
    "172.28.2.0/24"]

  database_subnets = [
    "172.28.200.0/24",
    "172.28.201.0/24",
    "172.28.202.0/24"]
}

