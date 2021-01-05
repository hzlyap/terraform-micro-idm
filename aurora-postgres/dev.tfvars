name   = "aurora-postgres-portal-dev"
port   = 5432
engine = "aurora-postgresql"

db_name         = "postgrescoeportaldev"
master_username = "master"

vpc_id             = "vpc-07b5701b02dd17230"
subnet_ids         = ["subnet-0e1ff36d1c9c1d32e","subnet-098e1843f37d677d7"]
subnet_cidr_blocks = ["10.197.32.0/20","10.197.96.0/20"]

storage_encrypted = true
instance_count    = 2
instance_type     = "db.r4.16xlarge"

backup_retention_period = 21
apply_immediately       = false
deletion_protection     = true
allow_connections_from_cidr_block = []

kms_key_arn = "arn:aws:kms:us-east-2:338453893816:key/04673684-3c9e-4879-9906-be85774f20c2"
