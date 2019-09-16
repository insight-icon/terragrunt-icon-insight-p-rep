terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name = "p-rep-logs-${get_aws_account_id()}"

  tags = "${map("Environment", "dev")}"
}
