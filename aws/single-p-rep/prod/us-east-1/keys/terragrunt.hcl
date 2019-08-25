terraform {
//  source = "github.com/cloudposse/terraform-aws-key-pair.git?ref=0.4.0"
  source = "github.com/robc-io/terraform-aws-icon-p-rep-keys.git"
}

include {
  path = find_in_parent_folders()
}

//inputs = {
//  stage = "stage"
//  name = "id_rsa"
////  ssh_public_key_path = "" # Inherited
//}

inputs = {
  resource_group = "keys"
}
