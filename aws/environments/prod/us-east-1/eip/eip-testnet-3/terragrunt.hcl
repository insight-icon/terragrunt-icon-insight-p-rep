terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

locals {
  environment_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("environment.yaml")}"))
}

dependency "ec2" {
  config_path = "../../prep/ec2-1"
}

inputs = {
  name = "main"

  instance_id = dependency.ec2.outputs.instance_id
  //  environment = local.environment_vars["environment"]
}

