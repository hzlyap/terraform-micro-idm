region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

node_count                  = 2
ami_id                      = "ami-031e0523d6e293d5c"
instance_type               = "t3.large"
key_pair                    = "stage-idm-engine-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-042df276a6e967f36"
