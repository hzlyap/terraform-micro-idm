variable "name" {
  description = "The name used to namespace all the Aurora resources created by these templates, including the cluster and cluster instances"
  default     = "aurora-postgres-portal-prod"
}

variable "port" {
  description = "The port the DB will listen on (e.g. 3306)" 
  type        = number
  default     = 5432
}

variable "engine" {
  description = "The name of the database engine to be used for the RDS instance. Must be one of: aurora, aurora-postgresql."
  default     = "aurora-postgresql"
} 

variable "db_name" {
  description = "The name for your database of up to 8 alpha-numeric characters"
  default     = "postgrescoeportal"
}

variable "master_username" {
  description = "The username for the master user"
  default     = "master"
}

variable "master_password" {}

variable "vpc_id" {
  description = "The name of the VPC to deploy int"
  default     = "vpc-076449537654b0bf9"
}

variable "subnet_ids" {
  type    = list
  default = ["subnet-0e94c9c9d3def590a","subnet-048e73d1bfe6732b2"]
}

variable "subnet_cidr_blocks" {
  type    = list
  default = ["10.197.16.0/20","10.197.80.0/20"]
}

variable "storage_encrypted" {
  description = "Specifies whether the DB cluster uses encryption for data at rest in the underlying storage"
  default     = true
}

variable "instance_count" {
  description = "The number of DB instances, including the primary, to run in the RDS cluster"
  default = 2
}

variable "instance_type" {
  description = "The instance type to use for the db (e.g. db.r3.large)"
  default     = "db.r4.16xlarge"
}

variable "backup_retention_period" {
  description = "How many days to keep backup snapshots around before cleaning them up"
  type        = number
  default     = 21
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true. The default is false"
  default = true
}

variable "allow_connections_from_cidr_blocks" {
  type    = list
  default = []
}

variable "kms_key_arn" {
  type    = string
  default = "arn:aws:kms:us-east-2:429331937010:key/3e812d05-2f06-459d-a96a-7edb16bbc342"
}
