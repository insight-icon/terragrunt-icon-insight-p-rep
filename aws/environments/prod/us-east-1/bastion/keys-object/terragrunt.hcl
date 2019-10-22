terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

locals {
  account_vars = yamldecode(file("${get_terragrunt_dir()}/${find_in_parent_folders("account.yaml")}"))
}

dependency "s3" {
  config_path = "../keys-bucket"
}

inputs = {
//  TODO: This needs an interpolation function -> split("/", ...)[-1]
  key_name = "id_rsa.pub"

  bucket = dependency.s3.outputs.this_s3_bucket_id
  public_key = local.account_vars["local_public_key"]
}
