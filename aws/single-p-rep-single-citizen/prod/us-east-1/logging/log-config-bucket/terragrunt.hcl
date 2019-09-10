terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name = "p-rep-log-configs-${get_aws_account_id()}"
  log_config_key = "log-config.json"

  tags = "${map("Environment", "dev")}"
}
