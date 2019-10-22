
variable "private_zone_id" {}
variable "vpc_id" {}

resource "aws_route53_zone_association" "secondary" {
  zone_id = var.private_zone_id
  vpc_id  = var.vpc_id
}