data "aws_region" "current" {}
variable "instance_id" {}

resource "aws_eip" "this" {

  tags = {
    Name = "main-ip"
    Region = data.aws_region.current.name
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_eip_association" "main" {
  instance_id = var.instance_id
  allocation_id = aws_eip.this.id
}

output "eip_id" {
  value = aws_eip.this.id
}