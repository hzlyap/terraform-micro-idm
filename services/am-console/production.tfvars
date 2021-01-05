region                      = "us-east-2" 
node_count                  = 1
vpc_id                      = "vpc-076449537654b0bf9"
subnet_id                   = ["subnet-02b23bd50184066b7"]
ami_id                      = "ami-048b2f3f858b1933f"
instance_type               = "t3.large"
key_pair                    = "prod-am-console-pem"
associate_public_ip_address = "false"
monitoring                  = "true"
storage                     = "100"
source_security_group_id    = "sg-0303ee9e9299de168"
vpc_cidr_block              = "10.197.0.0/16"

bucket_name = "prod-am-console"
