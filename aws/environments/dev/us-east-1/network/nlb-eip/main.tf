data "aws_region" "current" {}
variable "environment" {}

resource "aws_eip" "main" {

  tags = {
    Name = "main-ip"
    Environment = var.environment
    Region = data.aws_region.current.name
  }

  lifecycle {
    prevent_destroy = false
  }
}

output "eip_id" {
  value = aws_eip.main.id
}