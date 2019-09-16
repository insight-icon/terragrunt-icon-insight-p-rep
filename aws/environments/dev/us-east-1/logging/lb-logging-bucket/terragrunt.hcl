terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

inputs = {
  log_bucket_name = "p-rep-alb-logs-${get_aws_account_id()}"
  log_location_prefix = "p-rep-alb-logs"
  tags = {Environment :"dev"}
}
