terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling.git"
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "sg" {
  config_path = "../sg"
}

dependency "alb" {
  config_path = "../alb-p-rep"
}

dependency "node" {
  config_path = "../node"
}


inputs = {
  name = "service"
  spot_price = "1.2"

  target_group_arns = dependency.alb.outputs.target_group_arns
  p_rep_ip = dependendcy.node.outputs.private_ip

  # Launch configuration
  lc_name = "p-rep-sentry-lc"

  image_id = "data.aws_ami.ubuntu.id"
  instance_type = "t2.small"
  security_groups = dependency.sg.outputs.security_group_ids


  ebs_block_device = [
    {
      device_name = "/dev/xvdz"
      volume_type = "gp2"
      volume_size = "50"
      delete_on_termination = true
    }
  ]

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