variable "region" {
  description = "The region where to run the module"
}

variable "node_count" {
  description = "The number of instance to create" 
}

variable "vpc_id" {
  description = "The VPC ID where the instance is to be created"
}

variable "subnet_id" {
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

variable "associate_public_ip_address" {
  description = "If the EC2 resource should have a public address or not"
  type        = bool
}

variable "monitoring" {
  description = "If the EC2 resource should have monitoring"
  type        = bool
}

variable "storage" {
  description = "The storage size of the instance"
}

variable "source_security_group_id" {
  description = "The allowed security group for SSH only"
}
