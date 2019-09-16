data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

variable "bucket_name" {}

variable "tags" {
  type = map(string)
  default = {}
}
variable "force_destroy" {
  type = bool
  default = true
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl = "private"
//  policy = data.aws_iam_policy_document.bucket_policy.json
  force_destroy = var.force_destroy

  tags = var.tags
}

// TODO: This might privide extra control -> tbd in pattern
//data "aws_iam_policy_document" "bucket_policy" {
//  statement {
//    sid = "AllowEC2GetObjectFromS3Bucket"
//    actions = [
//      "s3:GetObject",
//      "s3:ListObject"]
//    resources = [
//      "arn:aws:s3:::${var.bucket_name}/*"]
//
//    principals {
//      type = "AWS"
//      identifiers = [
//        "arn:aws:ec2::${data.aws_caller_identity.this.id}:*"]
//    }
//  }
//
//  statement {
//    sid = "AllowEC2ListS3Bucket"
//    actions = [
//      "s3:GetObject",
//      "s3:ListBucket"]
//    resources = [
//      "arn:aws:s3:::${var.bucket_name}"]
//
//    principals {
//      type = "AWS"
//      identifiers = [
//        "arn:aws:ec2:${data.aws_region.this.name}:${data.aws_caller_identity.this.id}:*"]
//    }
//  }
//}

output "log_bucket" {
  value = var.bucket_name
}
