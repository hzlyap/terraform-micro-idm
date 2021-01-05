output "instance_id" {
  value = "${module.idm_engine_instance.instance_id}"
}

output "security_group_id" {
  value = "${module.idm_engine_instance.security_group_id}"
}

output "instance_role_arn" {
  value = "${module.idm_engine_instance.instance_role_arn}"
}
