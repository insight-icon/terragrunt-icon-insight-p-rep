module "iam_user" {
  source = "github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user?ref=v2.3.0"

  name          = "k8s-admin"
  create_iam_user_login_profile  = false
  create_iam_access_key         = true

  force_destroy = true
  password_reset_required = false
//  upload_iam_user_ssh_key = var.upload_iam_user_ssh_key
//  ssh_public_key = var.ssh_public_key
}

//variable "k8s_ssh_public_key" {
//  type = string
//}
