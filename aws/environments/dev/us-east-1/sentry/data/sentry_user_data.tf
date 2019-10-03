data "template_file" "user_data" {
  template = file("${path.module}/user-data/${var.user_data}")
}

variable "user_data" {
  type = string
  default = "user_data_sentry_ubuntu.sh"
}

output "sentry_user_data" {
  value = data.template_file.user_data.rendered
}