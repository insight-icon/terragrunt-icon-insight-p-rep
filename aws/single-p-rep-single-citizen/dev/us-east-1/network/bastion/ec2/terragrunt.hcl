terraform {
  source = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../../vpc"
}

dependency "sg" {
  config_path = "../sg"
}

dependency "data" {
  config_path = "../../../data"
}

inputs = {
  instance_type               = "t2.micro"
  ami                         = dependency.data.outputs.ubuntu_ami_id
  region                      = "us-east-1"
  iam_instance_profile        = "s3_readonly"
  s3_bucket_name              = "public-keys-${get_aws_account_id()}"
  vpc_id                      = dependency.vpc.outputs.vpc_id
  subnet_ids                  = dependency.vpc.outputs.public_subnets
  keys_update_frequency       = "5,20,35,50 * * * *"
  additional_user_data_script = "date"
}

