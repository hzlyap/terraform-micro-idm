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

module "idm_apps_instance" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//ec2_instance?ref=v0.0.16"

  name                        = "idm-apps"
  node_count                  = "${var.node_count}"
  vpc_id                      = "${var.vpc_id}"
  ami_id                      = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_pair                    = "${var.key_pair}"
  subnet_ids                  = "${var.subnet_id}"
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
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "idm_apps_nginx_rule" {
  security_group_id = module.idm_apps_instance.security_group_id

  type                     = "ingress"
  from_port                = 8600
  to_port                  = 8600
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "idm_apps_postgres_rule" {
  security_group_id = module.idm_apps_instance.security_group_id

  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}
