data "aws_region" "current" {}
variable "instance_id" {}

resource "aws_eip" "this" {

  tags = {
    Name = "main-ip"
    Region = data.aws_region.current.name
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_eip_association" "main" {
  count = var.instance_id == "" ? 0 : 1

  instance_id = var.instance_id
  allocation_id = aws_eip.this.id
}

output "eip_id" {
  value = aws_eip.this.id
}

output "public_ip" {
  value = aws_eip.this.public_ip
}