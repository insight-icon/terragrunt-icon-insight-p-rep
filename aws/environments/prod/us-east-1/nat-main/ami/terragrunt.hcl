terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

locals {}

inputs = {
//  name = "p-rep"
//  distro = "ubuntu-18"
//  node = "p-rep"
}

