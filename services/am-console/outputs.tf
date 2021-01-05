output "instance_id" {
  value = "${module.am_console_instance.instance_id}"
}

output "security_group_id" {
  value = "${module.am_console_instance.security_group_id}"
}

output "instance_role_arn" {
  value = "${module.am_console_instance.instance_role_arn}"
}
