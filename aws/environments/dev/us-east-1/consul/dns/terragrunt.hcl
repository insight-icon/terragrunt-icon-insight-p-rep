terraform {
  source = "../../../../../modules/terraform-aws-icon-consul-dns"
}

include {
  path = find_in_parent_folders()
}

dependency "dns-zone" {
  config_path = "../../network/dns"
}

inputs = {
  zone_id = dependency.dns-zone.outputs.zone_id
}