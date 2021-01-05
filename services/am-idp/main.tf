terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-dev-tfstate"
    key                  = "am-idp.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "am-idp"
    encrypt              = true
  }
}

provider "aws" {
  region = "${var.region}"
}

module "am_idp_nlb" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//network_load_balancer?ref=v0.0.23"

  name            = "am-idp"
  vpc_id          = "${var.vpc_id}"
  subnet_ids      = "${var.subnet_ids}"
  internal        = "${var.lb_internal}"
  ports           = "${var.ports}"
  port_protocol   = "${var.port_protocol}"
  certificate_arn = "${var.certificate_arn}"
}

module "am_idp_asg" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//autoscaling?ref=v0.0.18"

  name                        = "am-idp"
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

  lb_target_group_arn = module.am_idp_nlb.nlb_target_group_arn
}

resource "aws_security_group_rule" "am_idp_ssh_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "am_idp_federation_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_idm_authentication_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 2443
  to_port                  = 2443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_to_am_ac_rule" { 
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8444
  to_port                  = 8444  
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_to_novell_audit_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 1289
  to_port                  = 1289 
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_ncp_cert_mgt_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 524
  to_port                  = 524
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_ldap_to_ac_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 636
  to_port                  = 636
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_dns_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 53
  to_port                  = 53
  protocol                 = "UDP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}


resource "aws_security_group_rule" "am_idp_https_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_webserver_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_authenticate_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_idm_forms_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8600
  to_port                  = 8600
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_synchronization_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 1443
  to_port                  = 1443
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_configuration_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8446
  to_port                  = 8446
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}


resource "aws_security_group_rule" "am_idp_management_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7801
  to_port                  = 7801
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_management_rule1" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7802
  to_port                  = 7802
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_management_rule2" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7803
  to_port                  = 7803
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_management_rule4" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7804
  to_port                  = 7804
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_management_rule5" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 7805
  to_port                  = 7805
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}

resource "aws_security_group_rule" "am_idp_idm_management_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8445
  to_port                  = 8445
  protocol                 = "TCP"
  cidr_blocks              = ["${var.vpc_cidr_block}"]
}



module "am_idp_bucket" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//s3_buckets?ref=v0.0.20"

  bucket_name = "${var.bucket_name}"
}
