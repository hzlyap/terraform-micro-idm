region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 1
ami_id                      = "ami-0c35233c4bd0f0b64"
instance_type               = "t3.large"
key_pair                    = "stage-am-console-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-042df276a6e967f36"

bucket_name = "stage-am-console"
