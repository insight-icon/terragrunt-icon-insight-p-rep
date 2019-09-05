terraform {
//  source = "https://github.com/robc-io/terraform-aws-subdomain-simple"
  source = "../../../../../modules/terraform-aws-subdomain-simple"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  region = "us-east-1"
  subdomain = "prod"
  environment = "prod"
  name = "prod-redirect"
}

