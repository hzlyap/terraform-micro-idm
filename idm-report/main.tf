terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-tfstate"
    key                  = "idm-report.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "idm-report"
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

module "idm_report_instance" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//ec2_instance?ref=v0.0.16"

  name                        = "idm-report"
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

resource "aws_security_group_rule" "idm_report_ssh_rule" {
  security_group_id = module.idm_report_instance.security_group_id

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "TCP"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "idm_report_imanager_rule" {
  security_group_id = module.idm_report_instance.security_group_id

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}
