terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-tfstate"
    key                  = "idm-apps.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "idm-apps"
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

module "idm_apps_instance" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//ec2_instance?ref=v0.0.16"

  name                        = "idm-apps"
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

resource "aws_security_group_rule" "idm_apps_ssh_rule" {
  security_group_id = module.idm_apps_instance.security_group_id

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "idm_apps_tomcat_rule" {
  security_group_id = module.idm_apps_instance.security_group_id

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

resource "aws_security_group_rule" "idm_apps_nginx_rule" {
  security_group_id = module.idm_apps_instance.security_group_id

  type                     = "ingress"
  from_port                = 8600
  to_port                  = 8600
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

resource "aws_security_group_rule" "idm_apps_postgres_rule" {
  security_group_id = module.idm_apps_instance.security_group_id

  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidro_block"]
}
