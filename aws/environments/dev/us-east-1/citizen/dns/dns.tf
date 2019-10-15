data "aws_region" "this" {}

variable "domain_name" {}
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
    var.domain_name]
  )
}

resource "aws_route53_record" "www" {
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