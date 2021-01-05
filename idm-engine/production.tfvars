region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 2
ami_id                      = "ami-03f4c416f489586a3"
instance_type               = "t3.large"
key_pair                    = "prod-idm-engine-pem"
associate_public_ip_address = false
monitoring                  = true
storage                     = "100"
source_security_group_id    = "sg-0303ee9e9299de168"
