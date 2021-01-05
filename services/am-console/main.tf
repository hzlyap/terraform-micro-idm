terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-dev-tfstate"
    key                  = "am-console.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "am-console"
    encrypt              = true
  }
}

provider "aws" {
  region = "${var.region}"
}

module "am_console_instance" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//ec2_instance?ref=v0.0.20"

  name                        = "am-console"
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

resource "aws_security_group_rule" "am_console_ssh_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "am_console_imanager_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}
  
resource "aws_security_group_rule" "am_console_webserver_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 8444
  to_port                  = 8444
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_console_server_management_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 1289
  to_port                  = 1289
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_console_configuration_management_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 1290
  to_port                  = 1290
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_console_synchronization_port" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 1443
  to_port                  = 1443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_console_sldap_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 636
  to_port                  = 636
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_console_ncp_cert_mgmt_rule" {
  security_group_id = module.am_console_instance.security_group_id

  type                     = "ingress"
  from_port                = 524
  to_port                  = 524
  protocol                 = "UDP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

module "am_console_bucket" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//s3_buckets?ref=v0.0.20"   
 
  bucket_name = "${var.bucket_name}"
}
