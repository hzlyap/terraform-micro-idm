region                      = "us-east-2" 
node_count                  = 2
vpc_id                      = "vpc-0bd4aac6d73bb0530"
subnet_id                   = ["subnet-0237f7878ae5f1922","subnet-08c439f0013c3c639"]
ami_id                      = "ami-031e0523d6e293d5c"
instance_type               = "t3.large"
key_pair                    = "stage-idm-apps-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-042df276a6e967f36"
vpc_cidr_block              = "10.197.0.0/16" 