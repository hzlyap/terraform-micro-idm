region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 1
ami_id                      = "ami-0b6d87924d9be5e63"
instance_type               = "t3.xlarge"
key_pair                    = "prod-idm-report-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-0303ee9e9299de168"
