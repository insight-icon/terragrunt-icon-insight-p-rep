terraform {
  //  TODO When tf12 PR goes through then use this one https://github.com/terraform-community-modules/tf_aws_bastion_s3_keys/pull/56
  //  source = "github.com/terraform-community-modules/tf_aws_bastion_s3_keys"
//  source = "github.com/robc-io/tf_aws_bastion_s3_keys_tmp"
  source = "../../../../../../modules/tf_aws_bastion_s3_keys_tmp"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

dependency "data" {
  config_path = "../../../data"
}

dependency "s3" {
  config_path = "../keys-bucket"
}

dependency "profile" {
  config_path = "../../../../global/profiles/bastion"
}


// TODO keep this
inputs = {

//  allowed_security_groups = [""]

  instance_type               = "t2.micro"
  ami                         = dependency.data.outputs.ubuntu_ami_id
  region                      = "us-east-1"
  iam_instance_profile        = dependency.profile.outputs.instance_profile_id
  s3_bucket_name              = dependency.s3.outputs.this_s3_bucket_id
  vpc_id                      = dependency.vpc.outputs.vpc_id
  subnet_ids                  = [dependency.vpc.outputs.public_subnets[0]]
  keys_update_frequency       = "5,20,35,50 * * * *"
  additional_user_data_script = "date"


}

//inputs = {
//  subnet_id = dependency.vpc.outputs.public_subnets[0]
//  ssh_key = "ssh_key_name"
////  TODO constrict network subnets
//  internal_networks = [
//    "10.0.0.0/22"]
//  disk_size = 10
//  instance_type = "t2.micro"
//  project = "ICON"
//}