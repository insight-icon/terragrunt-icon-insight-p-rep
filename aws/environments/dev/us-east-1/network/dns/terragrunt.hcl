terraform {
  source = "github.com/shinyfoil/terraform-aws-icon-dns-setup.git"
}

include {
  path = find_in_parent_folders()
}

inputs = {

  root_domain_name = "aws.patchnotes.xyz"
  region = "{$var.aws_region}"

}