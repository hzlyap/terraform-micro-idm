terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-tfstate"
    key                  = "idm-engine.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "idm-engine"
    encrypt              = true
  }
}

provider "aws" {
  region = "${var.region}"
}

data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    region = "${var.region}"
    bucket = "${var.tfstate_bucket}"
    key    = "customer-portal-services/${terraform.workspace}/customer-portal-services.tfstate"
  }
}

module "idm_engine_instance" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//ec2_instance?ref=v0.0.16"

  name                        = "idm-engine"
  node_count                  = "${var.node_count}"
  vpc_id                      = "data.terraform_remote_state.networking.outputs.vpc_id"
  ami_id                      = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_pair                    = "${var.key_pair}"
  subnet_ids                  = ["data.terraform_remote_state.networking.outputs.public_subnet_ids[0]"]
  monitoring                  = "${var.monitoring}"
  storage                     = "${var.storage}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
}

resource "aws_security_group_rule" "idm_engine_ssh_rule" {
  security_group_id = module.idm_engine_instance.security_group_id

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "idm_engine_ldap_rule" {
  security_group_id = module.idm_engine_instance.security_group_id

  type                     = "ingress"
  from_port                = 389
  to_port                  = 389
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

resource "aws_security_group_rule" "idm_engine_ndap_rule" {
  security_group_id = module.idm_engine_instance.security_group_id

  type                     = "ingress"
  from_port                = 524
  to_port                  = 524
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

resource "aws_security_group_rule" "idm_engine_ldaps_rule" {
  security_group_id = module.idm_engine_instance.security_group_id

  type                     = "ingress"
  from_port                = 636
  to_port                  = 636
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

resource "aws_security_group_rule" "idm_engine_imonitor_rule" {
  security_group_id = module.idm_engine_instance.security_group_id

  type                     = "ingress"
  from_port                = 8030
  to_port                  = 8030
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

resource "aws_security_group_rule" "idm_engine_imanager_rule" {
  security_group_id = module.idm_engine_instance.security_group_id

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}
