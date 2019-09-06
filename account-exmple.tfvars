
//Put this in the base of the environment directory (ie prod / dev / stage) as this initializes sensistive information
//for your account.

account_id = "123456789012"
aws_allowed_account_ids = [
  "123456789012"]
terraform_state_region = "us-east-1"
terraform_state_bucket = "terraform-states-123456789012"

local_public_key = "/c/Users/rob/.ssh/blah.pub"

root_domain_name = "insight-icon.net"
subdomain = "dev"
domain_name = "dev.insight-icon.net"

stage = "dev"

corporate_ip = "1.2.3.4"
allowed_cidr = ["1.2.3.4/32"]
