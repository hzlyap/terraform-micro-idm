output "instance_role_arn" {
  value = "${module.am_idp_asg.instance_role_arn}"
}

output "instance_security_group" {
  value = "${module.am_idp_asg.instance_security_group}"
}

output "nlb_arn" {
  value = "${module.am_idp_nlb.nlb_arn}"
}

output "nlb_target_group_arn" {
  value = "${module.am_idp_nlb.nlb_target_group_arn}"
}

output "network_dns_name" {
  value = "${module.am_idp_nlb.network_dns_name}"
}

output "listener_arn" {
  value = "${module.am_idp_nlb.listener_arn}"
}
