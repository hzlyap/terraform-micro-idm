region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

ami_id                      = "ami-048b2f3f858b1933f"
instance_type               = "t3.large"
key_pair                    = "prod-am-ag-pem"
storage                     = 100
associate_public_ip_address = "true"
source_security_group_id    = "sg-0303ee9e9299de168"

asg_min_size         = 2
asg_max_size         = 4
asg_desired_capacity = 2
lb_internal          = "false"
ports                = ["80","443","8443","8600"]
port_protocol        = ["TCP","TLS","TCP","TCP"]
certificate_arn      = "arn:aws:acm:us-east-2:429331937010:certificate/098abd80-1db0-4882-9732-33fe179f09cb"

bucket_name = "prod-am-ag"
