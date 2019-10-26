terraform {
  source = "github.com/shinyfoil/terraform-aws-icon-ingress-dns.git"
}

include {
  path = find_in_parent_folders()
}

dependency "dns-zone" {
  config_path = "../dns"
}

inputs = {

  zone_id = dependency.dns-zone.outputs.public_zone_id
  root_domain_name = "aws.patchnotes.xyz"
  region = "{$var.aws_region}"

}