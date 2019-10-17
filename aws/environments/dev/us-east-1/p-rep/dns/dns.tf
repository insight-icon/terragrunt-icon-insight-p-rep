data "aws_region" "this" {}

variable "private_tld" {
  default = "consul"
}
//variable "environment" {}
variable "hostname" {}

variable "vpc_id" {}
variable "private_ip" {}

variable "force_destroy" {
  type = bool
  default = true
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "zone_id" {
  type = string
}

locals {
  fqdn = join(".", [
    var.hostname,
    data.aws_region.this.name,
    var.private_tld])
}

//resource "aws_route53_zone" "this" {
//  name = var.domain_name
//
//  vpc {
//    vpc_id = var.vpc_id
//    vpc_region = data.aws_region.this.current
//  }
//
//  force_destroy = var.force_destroy
//
//  tags = var.tags
//}


resource "aws_route53_record" "www" {
//  zone_id = aws_route53_zone.this.zone_id
  zone_id = var.zone_id

  name = local.fqdn
  type = "A"

  ttl = "5"
  records = [
    var.private_ip]
}

output "fqdn" {
  value = local.fqdn
}