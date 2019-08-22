terraform {
  source = "github.com/cloudposse/terraform-aws-key-pair.git?ref=0.4.0"
}

include {
  path = find_in_parent_folders()
}

locals {
  name = "vpc"
}

inputs = {
  generate_ssh_key = "false"
  name = "keypair"
  ssh_public_key_path =
}

