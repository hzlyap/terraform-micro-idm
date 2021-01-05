bucket_tfstate       = "customer-portal-services-stage-tfstate"
region               = "us-east-2"
availability_zones   = ["us-east-2a","us-east-2b"]
name                 = "microfocus"
vpc_cidr_block       = "10.197.0.0/16"
subnet_block_size    = "4"

multi_account_terraform_state_s3_bucket  = "microfocus-multi-stage-terraform-state"
multi_account_terraform_state_aws_region = "us-east-2"
