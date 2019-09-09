terraform {
  extra_arguments "custom_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/${find_in_parent_folders("region.tfvars")}",
      "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/${find_in_parent_folders("environment.tfvars")}",
      "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/${find_in_parent_folders("account.tfvars")}"
    ]
//    optional_var_files = [
//      "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/${find_in_parent_folders("group.tfvars")}",
//    ]
  }
}

remote_state {
  backend = "s3"

  config = {
    encrypt = true
    region = "us-east-1"
    key = "${path_relative_to_include()}/terraform.tfstate"
    bucket = "terraform-states-${get_aws_account_id()}"
    dynamodb_table = "terraform-locks-${get_aws_account_id()}"
  }
}