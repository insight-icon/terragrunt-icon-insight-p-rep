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
  name = "services-vpc"

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support = true

  azs = local.azs

  cidr = "172.16.0.0/16"

  public_subnets = [
    "172.16.0.0/21",
    "172.16.8.0/21",
    "172.16.16.0/21"]

  private_subnets = [
    "172.16.64.0/21",
    "172.16.72.0/21",
    "172.16.80.0/21"]

  public_subnet_tags = {
    "kubernetes.io/role/elb": 1,
    "kubernetes.io/cluster/ServicesCluster": "shared"
  }
  private_subnet_tags = {
    "service.beta.kubernetes.io/aws-load-balancer-internal": "true",
    "kubernetes.io/cluster/ServicesCluster": "shared"
  }
}

