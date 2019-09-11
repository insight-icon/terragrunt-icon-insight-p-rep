terraform {
  source = "github.com/cloudposse/terraform-aws-cloudtrail-s3-bucket.git"
}

include {
  path = find_in_parent_folders()
}

dependency "s3" {
  config_path = "../s3-cloudtrail"
}

inputs = {
  name = "cloudtrail-${get_aws_account_id()}"
  enable_log_file_validation = true
  include_global_service_events = true
  is_multi_region_trail = false
  enable_logging = true
  s3_bucket_name = dependency.s3.outputs.bucket_id
}
