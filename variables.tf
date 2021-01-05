variable "bucket_tfstate" {
  description = "The bucket where the Terraform state files would be stored"
}

variable "region" {
  description = "The region where to run the module"
}

variable "availability_zones" {
  description = "The availability zone for the subnets"
}

variable "vpc_cidr_block" {
  description = "The VPC CIDR block"
}

variable "subnet_block_size" {
  description = "The Subnet block size for the subnet"
}

variable "multi_account_terraform_state_aws_region" {
  description = "The region where the multi-account terraform state file was created"
}

variable "multi_account_terraform_state_s3_bucket" {
  description = "The name of the bucket where the multi-account terraform state is stored"
}