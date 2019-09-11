data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

variable "bucket_name" {}
variable "log_config_key" {}

variable "tags" {
  type = map(string)
  default = {}
}
variable "force_destroy" {
  type = bool
  default = true
}

variable "aggregation_dimensions" {
  description = "Specifies the dimensions that collected metrics are to be aggregated on."
  type = "list"

  default = [
    [
      "InstanceId"],
    //    ["AutoScalingGroupName"],
  ]
}

variable "cpu_resources" {
  description = "Specifies that per-cpu metrics are to be collected. The only allowed value is *. If you include this field and value, per-cpu metrics are collected."
  type = "string"
  default = "\"resources\": [\"*\"],"
}

variable "disk_resources" {
  description = "Specifies an array of disk mount points. This field limits CloudWatch to collect metrics from only the listed mount points. You can specify * as the value to collect metrics from all mount points. Defaults to the root / mountpount."
  type = "list"
  default = [
    "/"]
}

variable "metrics_collection_interval" {
  description = <<EOF
  Specifies how often to collect the cpu metrics, overriding the global metrics_collection_interval specified in the agent section of the configuration file. If you set this value below 60 seconds, each metric is collected as a high-resolution metric.
EOF

  type = "string"
  default = 60
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

data "template_file" "cloudwatch_agent_configuration" {
  template = file("${path.module}/data/cloudwatch_agent_configuration.json")

  vars = {
    aggregation_dimensions = jsonencode(var.aggregation_dimensions)
    cpu_resources = var.cpu_resources
    disk_resources = jsonencode(var.disk_resources)
    metrics_collection_interval = var.metrics_collection_interval
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.this.bucket
  key = var.log_config_key
  content = data.template_file.cloudwatch_agent_configuration.rendered
  //  etag = filemd5(data.template_file.cloudwatch_agent_configuration.rendered)
}

output "log_config_bucket" {
  value = var.bucket_name
}

output "log_config_key" {
  value = var.log_config_key
}