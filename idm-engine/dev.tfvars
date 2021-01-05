region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 2
ami_id                      = "ami-03549e4311aacf5a0"
instance_type               = "t3.large"
key_pair                    = "dev-idm-engine-pem"
associate_public_ip_address = false
monitoring                  = true
storage                     = "100"
source_security_group_id    = "sg-0af8fa6b796c71e00"
