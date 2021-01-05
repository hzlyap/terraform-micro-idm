output "instance_id" {
  value = "${module.bastion.instance_id}"
}

output "security_group_id" {
  value = "${module.bastion.security_group_id}"
}

output "instance_role_arn" {
  value = "${module.bastion.instance_role_arn}"
}
