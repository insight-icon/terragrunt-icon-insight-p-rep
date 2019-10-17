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

dependency "p-rep_ec2" {
  config_path = "../ec2"
}

inputs = {
  name = "p-rep-node-configuration"
  eip = dependency.p-rep_ec2.outputs.public_ip

  config_user = "ubuntu"

  config_playbook_file = "${get_terragrunt_dir()}/p-rep-config/configure.yml"
  config_playbook_roles_dir = "${get_terragrunt_dir()}/p-rep-config/roles"

//  config_playbook_file = "${get_parent_terragrunt_dir()}/configuration-playbooks/p-rep-config/configure.yml"
//  config_playbook_roles_dir = "${get_parent_terragrunt_dir()}/configuration-playbooks/p-rep-config/roles"

  //TODO: Will fix this if I need to provide tags
  tags = {}
}
