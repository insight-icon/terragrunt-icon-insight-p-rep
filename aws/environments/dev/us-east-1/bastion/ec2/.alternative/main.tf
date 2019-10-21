data "aws_region" "current" {}

locals {
  name = var.name
  common_tags = {
    "Name" = local.name
    "Terraform" = true
    "Environment" = var.environment
    "Region" = data.aws_region.current.name
  }

  tags = merge(var.tags, local.common_tags)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  owners = [
    "099720109477"]
  # Canonical
}

resource "aws_instance" "this" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  user_data = var.user_data
  subnet_id = var.subnet_id

  key_name = var.key_name

  vpc_security_group_ids = var.security_groups
  iam_instance_profile = var.instance_profile_id

  associate_public_ip_address = true

  tags = local.tags
}


resource "aws_eip" "this" {
  count = var.create_eip ? 1 : 0

  vpc = true
  lifecycle {
    prevent_destroy = "false"
  }

  tags = local.tags
}

resource "aws_eip_association" "this" {
  count = var.create_eip ? 1 : 0

  allocation_id = aws_eip.this.id
  instance_id = aws_instance.this.id
}


locals {
  public_dns = join(".", [
    var.hostname,
    var.root_domain_name])

  private_dns = join(".", [
    var.hostname,
    data.aws_region.current.name,
    var.private_tld])
}


resource "aws_route53_record" "public" {
  zone_id = var.public_zone_id

  name = local.public_dns
  type = "A"

  ttl = "5"
  records = [aws_eip.this.public_ip]
}

output "public_dns" {
  value = local.private_dns
}