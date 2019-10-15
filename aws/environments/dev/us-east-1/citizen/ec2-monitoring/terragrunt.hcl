terraform {
//  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git?ref=0.0.1"
//  source = "github.com/robcxyz/terraform-aws-icon-p-rep-node.git"
  source = "../../../../../modules/terraform-aws-icon-citizen-node"
}


include {
  path = find_in_parent_folders()
}

dependency "iam" {
  config_path = "../../../global/profiles/p-rep"
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

dependency "log_config" {
  config_path = "../../logging/log-config-bucket"
}

dependency "dns" {
  config_path = "../../network/dns"
}

inputs = {
  name = "citizen"

  volume_dir = ""
  ebs_volume_size = 100
  root_volume_size = "20"
  instance_type = "c4.2xlarge"
  volume_path = "/dev/sdf"

  key_name = dependency.keys.outputs.key_name
  public_key = dependency.keys.outputs.public_key

  security_groups = dependency.sg.outputs.security_group_ids
  subnet_id = dependency.vpc.outputs.public_subnets[0]

  instance_profile_id = dependency.iam.outputs.instance_profile_id

  log_config_bucket = dependency.log_config.outputs.log_config_bucket
  log_config_key = dependency.log_config.outputs.log_config_key

  user_data_script = "user_data_ubuntu_ebs.sh"

  zone_id = dependency.dns.outputs.zone_id
  domain = "us-east-1.aws.patchnotes.xyz"

  //  TODO: Fix this
  tags = {}
}