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
}

dependency "ec2" {
  config_path = "../ec2"
}

dependency "bastion" {
  config_path = "../../bastion/dns"
}

inputs = {
  name = "p-rep-node-configuration"
  eip = dependency.ec2.outputs.private_ip

  config_user = "ubuntu"

  bastion_dns = dependency.bastion.outputs.public_fqdn
  bastion_user = "ubuntu" # TODO: Make relative with output from packer when built that way

  config_playbook_file = "${get_parent_terragrunt_dir()}/configuration-playbooks/p-rep-config/configure.yml"
  config_playbook_roles_dir = "${get_parent_terragrunt_dir()}/configuration-playbooks/p-rep-config/roles"

  //TODO: Will fix this if I need to provide tags
  tags = {}
}
