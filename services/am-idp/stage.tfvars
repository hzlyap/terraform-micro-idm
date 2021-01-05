region                      = "us-east-2"
vpc_id                      = "vpc-0bd4aac6d73bb0530"
subnet_ids                  = ["subnet-0d7f8a3a61b90021e","subnet-034fac1519c4bbad5"]
ami_id                      = "ami-0c35233c4bd0f0b64"
instance_type               = "t3.large"
key_pair                    = "stage-am-idp-pem"
storage                     = 100
associate_public_ip_address = "true"
source_security_group_id    = "sg-042df276a6e967f36"                                   
vpc_cidr_block              = "10.197.0.0/16" 

asg_min_size         = 2
asg_max_size         = 4
asg_desired_capacity = 2
lb_internal          = "false"
ports                = ["443","8443"]
port_protocol        = ["TLS","TCP"]
certificate_arn      = "arn:aws:acm:us-east-2:785126472061:certificate/1aec5b0d-385e-4152-b671-02230950b50a"

bucket_name = "stage-am-idp"
