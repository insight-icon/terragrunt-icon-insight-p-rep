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

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  environment_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml")}"))
  region_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("region.yaml")}"))
}

dependency "iam" {
  config_path = "../iam"
}

dependency "vpc" {
  config_path = "../../network/vpc-mgmt"
}

dependency "sg" {
  config_path = "../sg"
}

dependency "user_data" {
  config_path = "../user-data"
}

dependency "log_config" {
  config_path = "../../logging/log-config-bucket"
}

//TODO TMP
dependency "keys" {
  config_path = "../../p-rep/keys"
}

inputs = {
  name = "bastion"

  create_eip = true

  environment = local.environment_vars["environment"]
  availability_zone = local.region_vars["azs"][0]

  ebs_volume_size = 0
  root_volume_size = 8
  instance_type = "t2.micro"
  volume_path = "/dev/sdf"

  key_name = dependency.keys.outputs.key_name

  user_data = dependency.user_data.outputs.user_data

  security_groups = [dependency.sg.outputs.this_security_group_id]
  subnet_id = dependency.vpc.outputs.public_subnets[0]

  instance_profile_id = dependency.iam.outputs.instance_profile_id

  log_config_bucket = dependency.log_config.outputs.log_config_bucket
  log_config_key = dependency.log_config.outputs.log_config_key

  tags = {}
}