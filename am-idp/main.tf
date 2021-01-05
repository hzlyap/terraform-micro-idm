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

data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    region = "${var.region}"
    bucket = "${var.tfstate_bucket}"
    key    = "customer-portal-services/${terraform.workspace}/customer-portal-services.tfstate"
  }
}

module "am_idp_nlb" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//network_load_balancer?ref=v0.0.23"

  name            = "am-idp"
  vpc_id          = "data.terraform_remote_state.networking.outputs.vpc_id"
  subnet_ids      = ["data.terraform_remote_state.networking.outputs.public_subnet_ids"]
  internal        = "${var.lb_internal}"
  ports           = "${var.ports}"
  port_protocol   = "${var.port_protocol}"
  certificate_arn = "${var.certificate_arn}"
}

module "am_idp_asg" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//autoscaling?ref=v0.0.18"

  name                        = "am-idp"
  vpc_id                      = "data.terraform_remote_state.networking.outputs.vpc_id"
  subnet_ids                  = ["data.terraform_remote_state.networking.outputs.public_subnet_ids"]
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
  protocol                 = "tcp"
  source_security_group_id = "${var.source_security_group_id}"
}

resource "aws_security_group_rule" "am_idp_federation_rule" {
  security_group_id = module.am_idp_asg.instance_security_group

  type                     = "ingress"
  from_port                = 8443
  to_port                  = 8443
  protocol                 = "TCP"
  cidr_blocks              = ["data.terraform_remote_state.networking.outputs.vpc_cidr_block"]
}

module "am_idp_bucket" {
  source = "git::git@github.com:hazelyap-mf/terraform-modules.git//s3_buckets?ref=v0.0.20"

  bucket_name = "${var.bucket_name}"
}
