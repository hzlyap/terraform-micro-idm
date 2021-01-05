region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

ami_id                      = "ami-05b39b8202f6b2103"
instance_type               = "t3.large"
key_pair                    = "dev-am-idp-pem"
storage                     = "100"
associate_public_ip_address = "true"
source_security_group_id    = "sg-0af8fa6b796c71e00"

asg_min_size         = 2
asg_max_size         = 4
asg_desired_capacity = 2
lb_internal          = "false"
ports                = ["8443","443"]
port_protocol        = ["TCP","TLS"]
certificate_arn      = "arn:aws:acm:us-east-2:338453893816:certificate/5e814bf3-dfed-4270-a829-1328492dad62"

bucket_name = "dev-am-idp"
