terraform {
  source = "."
}


include {
  path = find_in_parent_folders()
}

inputs = {
//  name = "PRep"
}

