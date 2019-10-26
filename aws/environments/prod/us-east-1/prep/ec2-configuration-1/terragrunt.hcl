terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "insight-infrastructure"
  repo_name = "terraform-aws-icon-node-configuration"
  repo_version = "master"
  repo_path = ""
  local_source = true

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"

  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
  environment_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml")}"))
}

dependency "bastion" {
  config_path = "../../bastion/dns"
}

dependency "eip" {
  config_path = "../../eip/eip-testnet-3"
}

inputs = {
  name = "p-rep-node-configuration"

//  eip = dependency.ec2.outputs.private_ip
  eip = dependency.eip.outputs.public_ip
  bastion_dns = dependency.bastion.outputs.public_fqdn
  bastion_user = "ubuntu" # TODO: Make relative with output from packer when built that way

  environment = local.environment_vars["environment"]
  config_private_key = local.account_vars["config_private_key"]

  config_user = "ubuntu"

  config_playbook_file = "${get_parent_terragrunt_dir()}/configuration-playbooks/p-rep-config/configure.yml"
  config_playbook_roles_dir = "${get_parent_terragrunt_dir()}/configuration-playbooks/p-rep-config/roles"

  playbook_vars = {
    "keystore_path" : local.account_vars["keystore_path"]
    "keystore_password": local.account_vars["keystore_password"]
  }

  //TODO: Will fix this if I need to provide tags
  tags = {}
}
