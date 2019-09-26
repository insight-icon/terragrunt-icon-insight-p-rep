terraform {
  source = "github.com/${local.repo_owner}/${local.repo_name}.git?ref=master"
//  source = "../../../../../modules/${local.repo_name}"
}

locals {
  repo_owner = "anocendi"
  repo_name = "terraform-aws-icon-node-configuration"
}


include {
  path = find_in_parent_folders()
}

dependency "citizen_ec2" {
  config_path = "../ec2"
}

inputs = {
  name = "citizen-node-configuration"
  eip = dependency.citizen_ec2.outputs.public_ip

  config_user = "ubuntu"
  config_playbook_file = "${get_parent_terragrunt_dir()}/configuration-playbooks/citizen-config/configure.yml"
  config_playbook_roles_dir = "${get_parent_terragrunt_dir()}/configuration-playbooks/citizen-config/roles"

  //TODO: Will fix this if I need to provide tags
  tags = {}
}
