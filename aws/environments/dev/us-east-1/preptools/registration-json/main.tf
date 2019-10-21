data "aws_caller_identity" "this" {}
data "aws_region" "this" {}

locals {
  region = var.region == "" ? data.aws_region.this.name : var.region
  bucket = var.bucket == "" ? "prep-registration-${random_pet.this.id}" : var.bucket
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket
  acl    = "public-read"
  policy = <<EOF
{
  "Id": "bucket_policy_site",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_policy_site_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${local.bucket}/*",
      "Principal": "*"
    }
  ]
}
EOF
}

data "template_file" "details" {
  template = file("${path.module}/details.json")
  vars = {
    logo_256 = var.logo_256
    logo_1024 = var.logo_1024
    logo_svg = var.logo_svg
    steemit = var.steemit
    twitter = var.twitter
    youtube = var.youtube
    facebook = var.facebook
    github = var.github
    reddit = var.reddit
    keybase = var.keybase
    telegram = var.telegram
    wechat = var.wechat

    country = var.organization_country
    region = local.region
    server_type = var.server_type

    p2p_ip = var.p2p_ip
  }
}

data "template_file" "registration" {
  template = file("${path.module}/registerPRep.json")
  vars = {
    name = var.organization_name
    country = var.organization_country
    city = var.organization_city
    email = var.organization_email
    website = var.organization_website

    details_endpoint = "https://${aws_s3_bucket.bucket.bucket}.s3.amazonaws.com/details.json"

    p2p_ip = var.p2p_ip
  }
  depends_on = [aws_s3_bucket.bucket]
}

resource "aws_s3_bucket_object" "details" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "details.json"
  content = data.template_file.details.rendered
}

resource "aws_s3_bucket_object" "registration" {
  bucket = aws_s3_bucket.bucket.bucket
  key    = "prep.json"
  content = data.template_file.registration.rendered
}