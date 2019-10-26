terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

inputs = {
  log_bucket_name = "prep-nlb-logs-${get_aws_account_id()}"
  log_location_prefix = "prep"
  tags = {Environment :"prod"}
}
