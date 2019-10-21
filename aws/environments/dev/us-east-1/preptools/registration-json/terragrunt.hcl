terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

locals {}

inputs = {
  region = "us-east-1"
}