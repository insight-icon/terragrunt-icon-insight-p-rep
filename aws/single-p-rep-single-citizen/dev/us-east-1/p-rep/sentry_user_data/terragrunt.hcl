terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

dependency "node" {
  config_path = "../node"
}

inputs = {
  name = "p-rep"
  p_rep_ip = dependency.node.outputs.private_ip
}
