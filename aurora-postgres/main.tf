terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket               = "customer-portal-services-stage-tfstate"
    key                  = "aurora-postgres.tfstate"
    region               = "us-east-2"
    workspace_key_prefix = "aurora-postgres"
    encrypt              = true
  }
}

provider "aws" {
  region = "us-east-2"
}

module "database" {
  source = "/home/hazelyap/01_REPOs/terraform-modules/aurora-postgres"

  name   = "${var.name}"
  port   = "${var.port}"
  engine = "${var.engine}"

  db_name = "${var.db_name}"

  master_username = "${var.master_username}"
  master_password = "${var.master_password}"

  vpc_id     = "${var.vpc_id}"
  subnet_ids = "${var.subnet_ids}"
  subnet_cidr_blocks = "${var.subnet_cidr_blocks}"
  allow_connections_from_cidr_blocks = "${var.subnet_cidr_blocks}"

#  allow_connections_from_security_groups = (
#    var.allow_connections_from_openvpn_server
#    ? [data.terraform_remote_state.openvpn_server.outputs.security_group_id]
#    : []
#  )

  storage_encrypted = "${var.storage_encrypted}"
  kms_key_arn       = "${var.kms_key_arn}"

  instance_count = "${var.instance_count}"
  instance_type  = "${var.instance_type}"

  backup_retention_period = "${var.backup_retention_period}"
  apply_immediately       = "${var.apply_immediately}"

  deletion_protection = "${var.deletion_protection}"
}
