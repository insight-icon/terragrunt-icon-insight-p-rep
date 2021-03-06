terraform {
//  source = "https://github.com/robc-io/terraform-aws-subdomain-root-ns"
  source = "../../../../../modules/terraform-aws-subdomain-root-ns"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  subdomain = "prod"
  environment = "prod"
  name = "prod-redirect"
}

