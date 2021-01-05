name   = "aurora-postgres-portal-prod"
port   = 5432
engine = "aurora-postgresql"

db_name         = "postgrescoeportal"
master_username = "master"

vpc_id             = "vpc-076449537654b0bf9"
subnet_ids         = ["subnet-0e94c9c9d3def590a","subnet-048e73d1bfe6732b2"]
subnet_cidr_blocks = ["10.197.16.0/20","10.197.80.0/20"]

storage_encrypted = true
instance_count    = 2
instance_type     = "db.r4.16xlarge"

backup_retention_period = 21
apply_immediately       = false
deletion_protection     = true
allow_connections_from_cidr_block = []

kms_key_arn = "arn:aws:kms:us-east-2:429331937010:key/3e812d05-2f06-459d-a96a-7edb16bbc342"
