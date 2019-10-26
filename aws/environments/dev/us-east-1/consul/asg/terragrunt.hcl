terraform {
  source = "github.com/hashicorp/terraform-aws-consul//modules/consul-cluster"
}
include {
  path = find_in_parent_folders()
}

dependency "vpc_support" {
  config_path = "../../network/vpc-support"
}

dependency "vpc_main" {
  config_path = "../../network/vpc-main"
}

dependency "vpc_services" {
  config_path = "../../network/vpc-services"
}

dependency "vpc_mgmt" {
  config_path = "../../network/vpc-mgmt"
}

dependency "bastion_sg" {
  config_path = "../../bastion/sg"
}

dependency "keys" {
  config_path = "../keys"
}

dependency "packer" {
  config_path = "../packer"
}

inputs = {
  name = "consul"

//  spot_price = 0.04

  cluster_name = "icon-consul"
  ami_id = dependency.packer.outputs.ami_id

  instance_type = "t2.micro"
  vpc_id = dependency.vpc_support.outputs.vpc_id

//  allowed_inbound_cidr_blocks = ["10.0.0.0/15"]  ## /15 to include both 10.0 and 10.1. Change if the VPCs change

  allowed_inbound_cidr_blocks = [
    dependency.vpc_main.outputs.vpc_cidr_block,
    dependency.vpc_services.outputs.vpc_cidr_block,
    dependency.vpc_mgmt.outputs.vpc_cidr_block,
    "10.100.0.0/16"]

  allowed_inbound_ssh_security_group_ids  = [dependency.bastion_sg.outputs.this_security_group_id]

  user_data = <<-EOF
                    #!/bin/bash
                    set -e
                    exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
                    tee -a /opt/consul/config/settings.json << CONSULCONFIG
                    {
                      "telemetry": {
                        "prometheus_retention_time": "24h",
                        "disable_hostname": true
                      }
                    }
                    CONSULCONFIG
                    /opt/consul/bin/run-consul --server --cluster-tag-key consul-servers --cluster-tag-value auto-join
                EOF

  cluster_size = 3
  cluster_tag_key = "consul-servers"
  cluster_tag_value = "auto-join"
  availability_zones = dependency.vpc_support.outputs.azs
  subnet_ids = dependency.vpc_support.outputs.public_subnets
  ssh_key_name = dependency.keys.outputs.key_name
}