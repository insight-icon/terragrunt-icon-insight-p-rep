terraform {
  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=v5.1.0"
  //  source = "github.com/${local.repo_owner}/${local.repo_name}.git"
  //  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "terraform-aws-modules"
  repo_name = "terraform-aws-eks"
}


inputs = {
  cluster_name = "my-cluster"


  tags = {
    environment = "test"
  }
}