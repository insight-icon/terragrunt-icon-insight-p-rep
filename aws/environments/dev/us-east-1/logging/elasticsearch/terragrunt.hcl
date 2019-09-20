terraform {
  source = "${local.source}"
}

include {
  path = find_in_parent_folders()
}

locals {
  repo_owner = "cloudposse"
  repo_name = "terraform-aws-elasticsearch"
  repo_version = "master"
  repo_path = ""
  local_source = false

  source = local.local_source ? "../../../../../modules/${local.repo_name}" : "github.com/${local.repo_owner}/${local.repo_name}.git//${local.repo_path}?ref=${local.repo_version}"
}

//dependency "iam" {
//  config_path = "../../../global/profiles/p-rep"
//}

dependency "vpc" {
  config_path = "../../network/vpc"
}

dependency "sg" {
  config_path = "../elasticsearch-sg"
}


// NOTES:

inputs = {
  name                    = "es"
  security_groups         = [dependency.sg.outputs.this_security_group_id]
  vpc_id                  = dependency.vpc.outputs.vpc_id
  subnet_ids              = dependency.vpc.outputs.public_subnets
  zone_awareness_enabled  = "true"
  elasticsearch_version   = "6.5"
  instance_type           = "m4.large.elasticsearch"  // Supported instance types -> https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/aes-supported-instance-types.html
  instance_count          = 4
//  iam_role_arns           = ["arn:aws:iam::XXXXXXXXX:role/ops", "arn:aws:iam::XXXXXXXXX:role/dev"]
//  iam_actions             = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost"]
  encrypt_at_rest_enabled = true
  kibana_subdomain_name   = "kibana-es"

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}


//Error: Error creating ElasticSearch domain: ValidationException: 1 validation error detected: Value 'm4.small.elasticsearch' at 'elasticsearc
//hClusterConfig.instanceType' failed to satisfy constraint: Member must satisfy enum value set: [i3.2xlarge.elasticsearch, m5.4xlarge.elastics
//earch, t3.xlarge.elasticsearch, i3.4xlarge.elasticsearch, m3.large.elasticsearch, r4.16xlarge.elasticsearch, t2.micro.elasticsearch, m4.large
//.elasticsearch, d2.2xlarge.elasticsearch, t3.micro.elasticsearch, m5.large.elasticsearch, i3.8xlarge.elasticsearch, i3.large.elasticsearch, d
//2.4xlarge.elasticsearch, t2.small.elasticsearch, c4.2xlarge.elasticsearch, t3.small.elasticsearch, c5.2xlarge.elasticsearch, c4.4xlarge.elast
//icsearch, d2.8xlarge.elasticsearch, c5.4xlarge.elasticsearch, m3.medium.elasticsearch, c4.8xlarge.elasticsearch, c4.large.elasticsearch, c5.x
//large.elasticsearch, c5.large.elasticsearch, c4.xlarge.elasticsearch, c5.9xlarge.elasticsearch, d2.xlarge.elasticsearch, t3.nano.elasticsearc
//h, t3.medium.elasticsearch, t2.medium.elasticsearch, t3.2xlarge.elasticsearch, c5.18xlarge.elasticsearch, i3.xlarge.elasticsearch, i2.xlarge.
//elasticsearch, r3.2xlarge.elasticsearch, r4.2xlarge.elasticsearch, m5.xlarge.elasticsearch, m4.10xlarge.elasticsearch, r3.4xlarge.elasticsear
//ch, r5.2xlarge.elasticsearch, m5.12xlarge.elasticsearch, m4.xlarge.elasticsearch, r4.4xlarge.elasticsearch, m5.24xlarge.elasticsearch, m3.xla
//rge.elasticsearch, i3.16xlarge.elasticsearch, t3.large.elasticsearch, r5.4xlarge.elasticsearch, m3.2xlarge.elasticsearch, r3.8xlarge.elastics
//earch, r3.large.elasticsearch, r5.xlarge.elasticsearch, m4.2xlarge.elasticsearch, r4.8xlarge.elasticsearch, r4.xlarge.elasticsearch, r4.large
//.elasticsearch, r5.12xlarge.elasticsearch, m5.2xlarge.elasticsearch, i2.2xlarge.elasticsearch, r3.xlarge.elasticsearch, r5.24xlarge.elasticse
//arch, r5.large.elasticsearch, m4.4xlarge.elasticsearch]
