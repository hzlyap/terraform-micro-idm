region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 1
ami_id                      = "ami-05b39b8202f6b2103"
instance_type               = "t3.large"
key_pair                    = "dev-am-console-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-0af8fa6b796c71e00"

bucket_name = "dev-am-console"
