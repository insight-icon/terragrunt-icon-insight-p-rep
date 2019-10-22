terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc-main"
}

inputs = {
  name = "main"

}

