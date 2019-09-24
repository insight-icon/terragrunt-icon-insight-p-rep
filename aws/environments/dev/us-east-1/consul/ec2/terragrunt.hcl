terraform {
  source = "github.com/hashicorp/terraform-aws-consul//modules/consul-cluster"
}
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "keys" {
  config_path = "../keys"
}

inputs = {
  name = "consul"
  cluster_name = "icon-consul"
  ami_id = "ami-06f898f4a2692dea4"
  instance_type = "t2.micro"
  vpc_id = dependency.vpc.outputs.vpc_id
  allowed_inbound_cidr_blocks = ["10.0.0.0/15"] ## /15 to include both 10.0 and 10.1. Change if the VPCs change
  user_data = <<-EOF
                #!/bin/bash
                set -e
                exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
                /opt/consul/bin/run-consul --server --cluster-tag-key consul-servers --cluster-tag-value auto-join
                EOF
  cluster_size = 3
  cluster_tag_key = "consul-servers"
  cluster_tag_value = "auto-join"
  availability_zones = dependency.vpc.outputs.azs
  spot_price = 0.04
  subnet_ids = dependency.vpc.outputs.public_subnets
  ssh_key_name = dependency.keys.outputs.key_name
}