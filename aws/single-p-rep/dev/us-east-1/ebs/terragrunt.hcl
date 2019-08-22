terraform {
//  source = "github.com/robcxyz/terragrunt-root-modules.git/aws/tendermint//tmtestnets"
  source = "../../modules//tmtestnet"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = [
    "../vpc"
  ]
}

dependency "keys" {
  config_path = "../keys"
}

inputs = {
  resource_group = "tmtestnets"
  group = "testnet"

  nodes = 2
  ami_id = "ami-0d344de126a83ea6b"
  instance_type = "t3.small"
  telegraf_collection_interval = "5s"
  influxdb_url = "http://localhost:8086"
  node_start_id = 1

  key_name = dependency.keys.outputs.key_name
//  key_name = [
//    "us-east-2",
//    "keys"
//  ]
}