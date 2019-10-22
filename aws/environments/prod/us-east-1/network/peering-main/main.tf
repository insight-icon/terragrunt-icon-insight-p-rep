data "aws_region" "current" {}

terraform {
  required_version = ">= 0.12"
}

locals {
  name = var.name
  common_tags = {
    "Terraform" = true
    "Environment" = var.environment
    "Region" = data.aws_region.current.name
  }

  tags = merge(var.tags, local.common_tags)
}

module "support" {
  source = "github.com/grem11n/terraform-aws-vpc-peering.git?ref=v2.1.0"

  providers = {
    aws.this = aws.main
    aws.peer = aws.ops
  }

  this_vpc_id = var.main_vpc_id
  peer_vpc_id = var.support_vpc_id

  auto_accept_peering = true

  this_dns_resolution        = true
//  this_link_to_peer_classic  = true
//  this_link_to_local_classic = true

  // Peering options for accepter
  peer_dns_resolution        = true
//  peer_link_to_peer_classic  = true
//  peer_link_to_local_classic = true

  tags = merge(local.tags, {"Name" = "support-${local.name}"})
}

module "mgmt" {
  source = "github.com/grem11n/terraform-aws-vpc-peering.git?ref=v2.1.0"

  providers = {
    aws.this = aws.main
    aws.peer = aws.ops
  }

  this_vpc_id = var.main_vpc_id
  peer_vpc_id = var.mgmt_vpc_id

  auto_accept_peering = true

  this_dns_resolution        = true
//  this_link_to_peer_classic  = true
//  this_link_to_local_classic = true

  // Peering options for accepter
  peer_dns_resolution        = true
//  peer_link_to_peer_classic  = true
//  peer_link_to_local_classic = true

  tags = merge(local.tags, {"Name" = "mgmt-${local.name}"})
}

module "services" {
  source = "github.com/grem11n/terraform-aws-vpc-peering.git?ref=v2.1.0"

  providers = {
    aws.this = aws.main
    aws.peer = aws.ops
  }

  this_vpc_id = var.main_vpc_id
  peer_vpc_id = var.services_vpc_id

  auto_accept_peering = true

  this_dns_resolution        = true
//  this_link_to_peer_classic  = true
//  this_link_to_local_classic = true

  // Peering options for accepter
  peer_dns_resolution        = true
//  peer_link_to_peer_classic  = true
//  peer_link_to_local_classic = true

  tags = merge(local.tags, {"Name" = "services-${local.name}"})
}


//data "aws_route_tables" "main_vpc" {
//  vpc_id   = var.main_vpc_id
//}
//
//data "aws_route_tables" "peer_vpc_rts" {
//  provider = "aws.peer"
//  vpc_id   = var.peer_vpc_id
//}
//
//resource "aws_vpc_peering_connection" "mgmt" {
//  vpc_id = var.main_vpc_id
//  peer_vpc_id = var.mgmt_vpc_id
//
//  auto_accept = var.auto_accept
//
//  accepter {
//    allow_remote_vpc_dns_resolution = var.mgmt_allow_remote_vpc_dns_resolution
//  }
//
//  requester {
//    allow_remote_vpc_dns_resolution = var.main_allow_remote_vpc_dns_resolution
//  }
//
//  tags = merge(local.tags, {"Name" = "mgmt-${local.name}"})
//}
//
//
//# Create routes from main to acceptor
//resource "aws_route" "main_mgmt" {
//  route_table_id            = var.main_vpc_route_table_id
//  destination_cidr_block    = var.mgmt_vpc_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt.id
//}
//
//# Create routes from acceptor to main
//resource "aws_route" "mgmt" {
//  route_table_id            = var.mgmt_vpc_route_table_id
//  destination_cidr_block    = var.main_vpc_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.mgmt.id
//}
//
//
//resource "aws_vpc_peering_connection" "services" {
//  vpc_id = var.main_vpc_id
//  peer_vpc_id = var.services_vpc_id
//
//  auto_accept = var.auto_accept
//
//  accepter {
//    allow_remote_vpc_dns_resolution = var.services_allow_remote_vpc_dns_resolution
//  }
//
//  requester {
//    allow_remote_vpc_dns_resolution = var.main_allow_remote_vpc_dns_resolution
//  }
//
//  tags = merge(local.tags, {"Name" = "services-${local.name}"})
//}
//
//
//# Create routes from main to acceptor
//resource "aws_route" "main_services" {
//  route_table_id            = var.main_vpc_route_table_id
//  destination_cidr_block    = var.services_vpc_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.services.id
//}
//
//# Create routes from acceptor to main
//resource "aws_route" "services" {
//  route_table_id            = var.services_vpc_route_table_id
//  destination_cidr_block    = var.main_vpc_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.services.id
//}
//
//
//resource "aws_vpc_peering_connection" "support" {
//  vpc_id = var.main_vpc_id
//  peer_vpc_id = var.support_vpc_id
//
//  auto_accept = var.auto_accept
//
//  accepter {
//    allow_remote_vpc_dns_resolution = var.support_allow_remote_vpc_dns_resolution
//  }
//
//  requester {
//    allow_remote_vpc_dns_resolution = var.main_allow_remote_vpc_dns_resolution
//  }
//
//  tags = merge(local.tags, {"Name" = "support-${local.name}"})
//}
//
//# Create routes from main to acceptor
//resource "aws_route" "main_support" {
//  route_table_id            = var.main_vpc_route_table_id
//  destination_cidr_block    = var.support_vpc_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.support.id
//}
//
//# Create routes from acceptor to main
//resource "aws_route" "support" {
//  route_table_id            = var.support_vpc_route_table_id
//  destination_cidr_block    = var.main_vpc_cidr_block
//  vpc_peering_connection_id = aws_vpc_peering_connection.support.id
//}

