terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.15.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  region_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("region.yaml")}"))
  azs = local.region_vars["azs"]
}

inputs = {
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support = true

  name = "main-vpc"

  azs = local.azs

  cidr = "10.0.0.0/16"

  private_subnets = [
    "10.0.0.0/20",
    "10.0.16.0/20",
    "10.0.32.0/20"]
  public_subnets = [
    "10.0.192.0/24",
    "10.0.193.0/24",
    "10.0.194.0/24"]
  database_subnets = [
    "10.0.224.0/24",
    "10.0.225.0/24",
    "10.0.226.0/24"]
}

