variable "region" {
  description = "The region where to run the module"
}

variable "node_count" {
  description = "The number of instance to create"
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
}

variable "monitoring" {
  description = "If the EC2 resource should have monitoring"
}

variable "storage" {
  description = "The storage size of the instance"
}

variable "source_security_group_id" {
  description = "The allowed security group for SSH only"
}

variable "bucket_name" {
  description = "The bucket name to create"
}
