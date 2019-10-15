variable "environment" {
  type = string
}

variable "region" {
  type = string
}

variable "mgmt_vpc_id" {
  type = string
}

variable "mgmt_vpc_route_table_id" {
  type = string
}
variable "mgmt_vpc_cidr_block" {
  type = string
}

variable "services_vpc_id" {
  type = string
}

variable "services_vpc_route_table_id" {
  type = string
}
variable "services_vpc_cidr_block" {
  type = string
}

variable "support_vpc_id" {
  type = string
}

variable "support_vpc_route_table_id" {
  type = string
}
variable "support_vpc_cidr_block" {
  type = string
}

variable "main_vpc_id" {
  type = string
}

variable "main_vpc_route_table_id" {
  type = string
}

variable "main_vpc_cidr_block" {
  type = string
}

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "auto_accept" {
  default = "true"
  description = "Automatically accept the peering (both VPCs need to be in the same AWS account)"
}

variable "mgmt_allow_remote_vpc_dns_resolution" {
  default = "true"
  description = "Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the main VPC"
}

variable "services_allow_remote_vpc_dns_resolution" {
  default = "true"
  description = "Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the main VPC"
}

variable "support_allow_remote_vpc_dns_resolution" {
  default = "true"
  description = "Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the main VPC"
}

variable "main_allow_remote_vpc_dns_resolution" {
  default = "true"
  description = "Allow main VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the acceptor VPC"
}

