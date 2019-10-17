terraform {
//  TODO: Pin this AFTER they release v4.X -> https://github.com/terraform-aws-modules/terraform-aws-alb/releases
  source = "github.com/terraform-aws-modules/terraform-aws-alb"
}

include {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../sg"
}

dependency "vpc" {
  config_path = "../../network/vpc-main"
}

dependency "acm" {
  config_path = "../../../global/dns/sub-acm"
}

//dependency "alb_p_rep_log_bucket" {
//  config_path = "../alb-p-rep-log-bucket"
//}


//locals = {
//  https_listeners = join("", ["${list(map("certificate_arn", "dependency.acm.outputs.this_acm_certificate_arn", "port", 7100))}"
//}


inputs = {
  //  log_bucket_name = dependency.alb_p_rep_log_bucket.outputs.aws_logs_bucket
  log_bucket_name = "p-rep-alb-logs-${get_aws_account_id()}"
  log_location_prefix = "p-rep-alb-logs"

  load_balancer_name = "p-rep-alb"
//  security_groups = [dependency.sg.outputs.security_group_ids[0]]
  security_groups = dependency.sg.outputs.security_group_ids
  subnets = dependency.vpc.outputs.public_subnets
  tags = "${map("Environment", "dev")}"
  vpc_id = dependency.vpc.outputs.vpc_id
  https_listeners = list({"certificate_arn" = dependency.acm.outputs.this_acm_certificate_arn, "port" = 7100})
  https_listeners_count = 1
  http_tcp_listeners = "${list(map("port", "80", "protocol", "HTTP"))}"
  http_tcp_listeners_count = 1
  target_groups = "${list(map("name", "p-rep-tg", "backend_protocol", "HTTPS", "backend_port", "7100"))}"
  target_groups_count = "1"
}
