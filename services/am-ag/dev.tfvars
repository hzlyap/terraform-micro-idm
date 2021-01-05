region                      = "us-east-2"
vpc_id                      = "vpc-07b5701b02dd17230"
subnet_ids                  = ["subnet-061e9dd32f21d91d7","subnet-09807a48a70a3f2c4"]
ami_id                      = "ami-05b39b8202f6b2103"
instance_type               = "t3.large"
key_pair                    = "dev-am-ag-pem"
storage                     = 100
associate_public_ip_address = "true"
source_security_group_id    = "sg-0af8fa6b796c71e00"
vpc_cidr_block              = "10.197.0.0/16"

asg_min_size         = 2
asg_max_size         = 4
asg_desired_capacity = 2
lb_internal          = "false"
ports                = ["80","443","8443","8600"]
port_protocol        = ["TCP","TLS","TCP","TCP"]
certificate_arn      = "arn:aws:acm:us-east-2:338453893816:certificate/5e814bf3-dfed-4270-a829-1328492dad62"

bucket_name = "dev-am-ag"
