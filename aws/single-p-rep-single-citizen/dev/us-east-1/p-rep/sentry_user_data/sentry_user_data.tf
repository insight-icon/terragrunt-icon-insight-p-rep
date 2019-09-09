data "template_file" "user_data" {
  template = file("${path.module}/data/user_data_sentry_ubuntu.sh")

  vars = {
    p_rep_ip = var.p_rep_ip
  }
}

variable "p_rep_ip" {}

output "sentry_user_data" {
  value = data.template_file.user_data.rendered
}