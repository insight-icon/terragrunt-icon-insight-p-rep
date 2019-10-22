variable "bucket" {}
variable "public_key" {}
variable "key_name" {}

resource "aws_s3_bucket_object" "object" {
  bucket = var.bucket
  key    = var.key_name
  source = var.public_key

  etag = filemd5(var.public_key)
}
