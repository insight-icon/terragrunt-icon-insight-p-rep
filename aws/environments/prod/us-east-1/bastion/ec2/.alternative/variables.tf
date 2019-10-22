variable "region" {
  description = "The region you are deploying into"
}

variable "environment" {
  description = "The environment that generally corresponds to the account you are deploying into."
}

variable "name" {
  description = "The name to be used in tags"
}

variable "tags" {
  description = "Tags that are appended"
  type        = map(string)
}

//----------------------------

variable "instance_type" {
  type = string
}
variable "root_volume_size" {
  type = number
}
variable "volume_path" {
  type = string
  default = "/dev/sdf"
}

variable "ebs_volume_size" {
  type = number
}

variable "ebs_prevent_destroy" {
  type = bool
  default = false
}

variable "ec2_prevent_destroy" {
  type = bool
  default = false
}

//----------------------------

variable "key_name" {
  type = string
}

variable "security_groups" {
  type = list
}

variable "azs" {
  description = "The availablity zones to deploy each ebs volume into."
  type        = list(string)
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "create_eip" {
  type = bool
  default = false
}

//----------------------------

variable "instance_profile_id" {
  type = string
}

variable "log_config_bucket" {
  type = string
  default = ""
}
variable "log_config_key" {
  type = string
  default = ""
}

variable "user_data_script" {
  type = string
  default = "user_data_ubuntu_ebs.sh"
}

variable "user_data" {
  type = string
  default = ""
}

variable "ami_id" {
  type = string
  default = ""
}

//------------------------------


variable "private_tld" {
  default = "consul"
}

//variable "environment" {}
variable "hostname" {
  default = "bastion"
}

variable "root_domain_name" {
  type = string
}

variable "private_zone_id" {
  type = string
}

variable "public_zone_id" {
  type = string
}
