data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

data "template_file" "registration" {
  template = file("${path.module}/policies/s3-remote-state-role-policy.json")
  vars = {}
}


resource "aws_s3_bucket_object" "object" {
  bucket = var.bucket
  key    = "prep.json"
  source = ""

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = "${filemd5("path/to/file")}"
}