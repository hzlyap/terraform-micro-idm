region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 1
ami_id                      = "ami-048b2f3f858b1933f"
instance_type               = "t3.large"
key_pair                    = "prod-am-console-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-0303ee9e9299de168"

bucket_name = "prod-am-console"
