terraform {
//  source = "github.com/robc-io/terraform-aws-subdomain-acm.git"
//  source = "../../../../../modules/terraform-aws-subdomain-acm"
  source = "github.com/terraform-aws-modules/terraform-aws-acm.git?ref=v2.3.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  domain_name = "${var.subdomain}.${var.root_domain_name}"
  subject_alternative_names = [
    "${var.subdomain}.${var.root_domain_name}"
  ]

  tags = {
    Name = "subdomain-acm-cert"
  }
}


