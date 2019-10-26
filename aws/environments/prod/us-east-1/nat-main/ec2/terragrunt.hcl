terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-p-rep-node"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"

  environment_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml")}"))
  region_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("region.yaml")}"))
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "sg" {
  config_path = "../sg"
}

dependency "keys" {
  config_path = "../keys"
}

dependency "ami" {
  config_path = "../ami"
}

dependency "user_data" {
  config_path = "../user-data"
}

inputs = {
  name = "nat"

  ebs_volume_size = 0
  root_volume_size = 8
  instance_type = "c4.large"

  ami_id = dependency.ami.outputs.amazon_linux

  region = local.region_vars["region"]
  availability_zone = local.region_vars["azs"][0]
  environment = local.environment_vars["environment"]

  user_data = dependency.user_data.outputs.user_data

  key_name = dependency.keys.outputs.key_name
  public_key = dependency.keys.outputs.public_key

  security_groups = [dependency.sg.outputs.this_security_group_id]
  subnet_id = dependency.vpc.outputs.public_subnets[0]

  tags = {}
}