terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling.git"
}

include {
  path = find_in_parent_folders()
}

dependency "data" {
  config_path = "../../data"
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "sg" {
  config_path = "../sg"
}

dependency "data" {
  config_path = "../data"
}

//dependency "nlb" {
//  config_path = "../../network/nlb-p-rep"
//}


inputs = {
  name = "public"
  spot_price = "1"

  user_data = dependency.data.outputs.sentry_user_data

  # Launch configuration
  lc_name = "p-rep-sentry-lc"

  image_id = dependency.data.outputs.ubuntu_ami_id
  instance_type = "m4.2xlarge"
  security_groups = [dependency.sg.outputs.this_security_group_id]

//  target_group_arns	= list(dependency.nlb.outputs.sentry_target_group_arns)

//  ebs_block_device = [
//    {
//      device_name = "/dev/xvdz"
//      volume_type = "gp2"
//      volume_size = "50"
//      delete_on_termination = true
//    }
//  ]

  //TODO: Trim this
  root_block_device = [
    {
      volume_size = "20"
      volume_type = "gp2"
    }
  ]

  # Auto scaling group
  asg_name = "p-rep-sentry-asg"
  vpc_zone_identifier = dependency.vpc.outputs.public_subnets

  health_check_type = "EC2"
  //  TODO Verify ^^
  min_size = 1
  max_size = 3
  desired_capacity = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key = "Environment"
      value = "dev"
      propagate_at_launch = true
    }
  ]
}