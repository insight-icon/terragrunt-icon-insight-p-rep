terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "robc-io"
  repo_name = "tf_aws_bastion_s3_keys_tmp"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}
//  TODO When tf12 PR goes through then use this one https://github.com/terraform-community-modules/tf_aws_bastion_s3_keys/pull/56

dependency "vpc" {
  config_path = "../../network/vpc-mgmt"
}

dependency "sg" {
  config_path = "../sg"
}

dependency "data" {
  config_path = "../../data"
}

dependency "s3" {
  config_path = "../keys-bucket"
}

dependency "profile" {
  config_path = "../iam"
}

inputs = {
  name = "bastion"

//  allowed_security_groups = [""]

  instance_type               = "t2.micro"
  ami                         = dependency.data.outputs.ubuntu_ami_id
  iam_instance_profile        = dependency.profile.outputs.instance_profile_id
  vpc_id                      = dependency.vpc.outputs.vpc_id
  subnet_ids                  = [dependency.vpc.outputs.public_subnets[0]]
  bastion_security_group      = dependency.sg.outputs.this_security_group_id

  s3_bucket_name              = dependency.s3.outputs.this_s3_bucket_id
  keys_update_frequency       = "5,20,35,50 * * * *"
  additional_user_data_script = "date"
}
