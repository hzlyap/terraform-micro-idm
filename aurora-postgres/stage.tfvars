name   = "aurora-postgres-portal-stage"
port   = 5432
engine = "aurora-postgresql"

db_name         = "postgrescoeportalstage"
master_username = "master"

vpc_id             = "vpc-0bd4aac6d73bb0530"
subnet_ids         = ["subnet-04308d855af527ecb","subnet-01b76f40bdce9bfdf"]
subnet_cidr_blocks = ["10.197.32.0/20","10.197.96.0/20"]

storage_encrypted = true
instance_count    = 2
instance_type     = "db.r4.16xlarge"

backup_retention_period = 21
apply_immediately       = false
deletion_protection     = true

allow_connections_from_cidr_block = []

kms_key_arn = "arn:aws:kms:us-east-2:785126472061:key/8ab7ebd1-42a1-4889-94c7-7c17d8239713"
