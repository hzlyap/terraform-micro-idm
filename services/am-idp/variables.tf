variable "region" {
  description = "The region where to run the module"
}

variable "vpc_id" {
  description = "The VPC ID where the instance is to be created"
}

variable "subnet_ids" {
  description = "The Subnet IDs where the instance is to be created"
  type        = list
}

variable "ami_id" {
  description = "The AMI ID of the instance"
}

variable "instance_type" {
  description = "The instance type"
}

variable "key_pair" {
  description = "The Key Pair for the instance"
}

variable "storage" {
  description = "The storage size of the instance"
}

variable "associate_public_ip_address" {
  description = "If the EC2 instance should have a public IP"
}

variable "source_security_group_id" {
  description = "The allowed security group for SSH only"
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
}

variable "asg_min_size" {
  description = "The minimum size of the auto scale group"
}

variable "asg_max_size" {
  description = "The maximum size of the auto scale group"
}

variable "asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "lb_internal" {
  description = "If true, the LB will be internal"
}

variable "ports" {
  description = "The port/s on which the load balancer is listening"
  type        = list
}

variable "port_protocol" {
  description = "Port protocol (e.g. TCP, UDP, HTTP, HTTPS, etc)"
  type        = list
}

variable "certificate_arn" {
  description = "The ARN of the default SSL server certificate"
}

variable "bucket_name" {
  description = "The bucket name to create"
}
