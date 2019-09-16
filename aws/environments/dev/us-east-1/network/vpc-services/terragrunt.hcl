
terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  enable_nat_gateway = "false"
//  single_nat_gateway = "false"
  name = "services-vpc"
  enable_dns_hostnames = "true"
  enable_dns_support = "true"

  azs = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c"]

  cidr = "10.1.0.0/16"
  // Running P-Rep in 1b - smaller subnet with one bastion
  private_subnets = [
    "10.1.0.0/24",
    "10.1.1.0/24",
    "10.1.2.0/24"]
  public_subnets = [
    "10.1.3.0/24",
    "10.1.4.0/24",
    "10.1.5.0/24"]
}

