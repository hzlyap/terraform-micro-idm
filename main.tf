terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-stage-tfstate"
    key                  = "customer-portal-services.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "customer-portal-services"
    encrypt              = true
  }
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket_policy" "tfstate" {
  bucket = "${var.bucket_tfstate}"

  policy = <<POLICY
{
    "Id": "SSLPolicy",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSSLRequestsOnly",
            "Action": "s3:*",
            "Effect": "Deny",
            "Resource": [
                "arn:aws:s3:::${var.bucket_tfstate}",
                "arn:aws:s3:::${var.bucket_tfstate}/*"
            ],
            "Condition": {
                "Bool": {
                     "aws:SecureTransport": "false"
                }
            },
           "Principal": "*"
        }
    ]
}
POLICY
}

module "customer_portal_vpc" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//networking?ref=v0.0.19"

  name        = "portal-${terraform.workspace}"
  environment = "${terraform.workspace}"

  region             = "${var.region}"
  vpc_cidr_block     = "${var.vpc_cidr_block}"
  subnet_block_size  = "${var.subnet_block_size}"
  availability_zones = "${var.availability_zones}"
}

module "mgmt_vpc_peering_connection" {
  source = "git::git@github.com:gruntwork-io/module-vpc.git//modules/vpc-peering?ref=v0.9.0"

  # Assume the first listed AWS Account Id is the one that should own the peering connection
  aws_account_id = data.aws_caller_identity.current.account_id

  origin_vpc_id         = data.terraform_remote_state.mgmt_vpc.outputs.vpc_id
  origin_vpc_name       = data.terraform_remote_state.mgmt_vpc.outputs.vpc_name
  origin_vpc_cidr_block = data.terraform_remote_state.mgmt_vpc.outputs.vpc_cidr_block
  origin_vpc_route_table_ids = concat(
    data.terraform_remote_state.mgmt_vpc.outputs.private_subnet_route_table_ids,
    [data.terraform_remote_state.mgmt_vpc.outputs.public_subnet_route_table_id]
  )

  # We should be able to compute these numbers automatically, but can't due to a Terraform bug:
  # https://github.com/hashicorp/terraform/issues/3888. Therefore, we make some assumptions: there is one
  # route table per availability zone in private subnets and just one route table in public subnets.
  num_origin_vpc_route_tables = data.terraform_remote_state.mgmt_vpc.outputs.num_availability_zones + 1

  destination_vpc_id         = module.customer_portal_vpc.vpc_id
  destination_vpc_name       = module.customer_portal_vpc.vpc_name
  destination_vpc_cidr_block = module.customer_portal_vpc.vpc_cidr_block
  destination_vpc_route_table_ids = concat(
    [module.customer_portal_vpc.public_subnet_route_table_id],
    module.customer_portal_vpc.private_subnet_route_table_ids
  )

  # We should be able to compute these numbers automatically, but can't due to a Terraform bug:
  # https://github.com/hashicorp/terraform/issues/3888. Therefore, we make some assumptions: there is one
  # route table per availability zone in private subnet and just one route table in public subnets.
  num_destination_vpc_route_tables = length(var.availability_zones) + 1
}

data "terraform_remote_state" "mgmt_vpc" {
  backend = "s3"
  config = {
    region = var.multi_account_terraform_state_aws_region
    bucket = var.multi_account_terraform_state_s3_bucket
    key    = "${var.region}/mgmt/vpc/terraform.tfstate"
  }
}

data "aws_caller_identity" "current" {}
