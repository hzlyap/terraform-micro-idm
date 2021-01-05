region                      = "us-east-2" 
node_count                  = 1
vpc_id                      = "vpc-0bd4aac6d73bb0530"
subnet_id                   = ["subnet-0237f7878ae5f1922"]
ami_id                      = "ami-0c35233c4bd0f0b64"
instance_type               = "t3.large"
key_pair                    = "stage-am-console-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-042df276a6e967f36"
vpc_cidr_block              = "10.197.0.0/16" 

bucket_name = "stage-am-console"
