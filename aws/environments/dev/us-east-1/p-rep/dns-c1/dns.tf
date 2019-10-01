data "aws_region" "this" {}


variable "vpc_id" {}
variable "domain_name" {}
variable "private_ip" {}

variable "tags" {
  type = map(string)
  default = {}
}

resource "aws_route53_zone" "this" {
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
    vpc_region = data.aws_region.this.current
  }

  tags = var.tags
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.this.zone_id}"
  name    = var.domain_name
  type    = "A"

  ttl = "5"
  records = [var.private_ip]
}
