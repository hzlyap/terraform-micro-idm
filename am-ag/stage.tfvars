region         = "us-east-2"
tfstate_bucket = "customer-portal-services-tfstate"

ami_id                      = "ami-0c35233c4bd0f0b64"
instance_type               = "t3.large"
key_pair                    = "stage-am-ag-pem"
storage                     = 100
associate_public_ip_address = "true"
source_security_group_id    = "sg-042df276a6e967f36"

asg_min_size         = 2
asg_max_size         = 4
asg_desired_capacity = 2
lb_internal          = "false"
ports                = ["80","443","8443","8600"]
port_protocol        = ["TCP","TLS","TCP","TCP"]
certificate_arn      = "arn:aws:acm:us-east-2:785126472061:certificate/1aec5b0d-385e-4152-b671-02230950b50a"

bucket_name = "stage-am-ag"
