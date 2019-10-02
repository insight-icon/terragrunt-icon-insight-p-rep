data "aws_region" "this" {}


variable "vpc_id" {}
variable "domain_name" {}
variable "hostname" {}
variable "private_ip" {}

variable "force_destroy" {
  type = bool
  default = true
}

variable "tags" {
  type = map(string)
  default = {}
}

locals {
  fqdn = join(".", [var.hostname, var.domain_name])
}

resource "aws_route53_zone" "this" {
  name = var.domain_name

  vpc {
    vpc_id = var.vpc_id
    vpc_region = data.aws_region.this.current
  }

  force_destroy = var.force_destroy

  tags = var.tags
}


resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.this.zone_id}"
  name    = var.domain_name
  type    = "A"

  ttl = "5"
  records = [var.private_ip]
}
