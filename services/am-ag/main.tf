terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-tfstate"
    key                  = "am-ag.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "am-ag"
    encrypt              = true
  }
}

provider "aws" {
  region = "${var.region}"
}

module "am_ag_nlb" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//network_load_balancer?ref=v0.0.23"

  name            = "am-ag"
  vpc_id          = "${var.vpc_id}"
  subnet_ids      = "${var.subnet_ids}"
  internal        = "${var.lb_internal}"
  ports           = "${var.ports}"
  port_protocol   = "${var.port_protocol}"
  certificate_arn = "${var.certificate_arn}" 
}

module "am_ag_asg" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//autoscaling?ref=v0.0.18"

  name                        = "am-ag"
  vpc_id                      = "${var.vpc_id}"
  subnet_ids                  = "${var.subnet_ids}"
  ami_id                      = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  key_pair                    = "${var.key_pair}"
  storage                     = "${var.storage}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

  asg_min_size         = "${var.asg_min_size}"
  asg_max_size         = "${var.asg_max_size}"
  asg_desired_capacity = "${var.asg_desired_capacity}"

  lb_target_group_arn = module.am_ag_nlb.nlb_target_group_arn
}

resource "aws_security_group_rule" "am_ag_ssh_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "am_ag_https_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_federation_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_webserver_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_idm_forms_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8600
  to_port                  = 8600
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_synchronization_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 1443
  to_port                  = 1443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_configuration_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8446
  to_port                  = 8446
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_management_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7801
  to_port                  = 7801
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_management_rule1" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7802
  to_port                  = 7802
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_management_rule3" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7803
  to_port                  = 7803
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_management_rule4" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7804
  to_port                  = 7804
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_management_rule5" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7805
  to_port                  = 7805
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_idm_management_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8445
  to_port                  = 8445
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_authenticate_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_to_am_ac_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8444
  to_port                  = 8444
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_to_novell_audit_rule" {                     
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 1289
  to_port                  = 1289
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_ncp_cert_mgt_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 524
  to_port                  = 524
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_ldap_to_ac_rule" {   
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 636
  to_port                  = 636
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_ntp_rule" { 
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 123
  to_port                  = 123
  protocol                 = "UDP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_ag_dns_rule" {
  security_group_id = module.am_ag_asg.instance_security_group

  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "UDP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

module "am_ag_bucket" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//s3_buckets?ref=v0.0.20"

  bucket_name = "${var.bucket_name}" 
}
