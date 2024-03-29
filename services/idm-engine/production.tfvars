region                      = "us-east-2"
node_count                  = 2
vpc_id                      = "vpc-076449537654b0bf9"
subnet_id                   = ["subnet-0a3b46ad6117e777f","subnet-02b23bd50184066b7"]
ami_id                      = "ami-03f4c416f489586a3"
instance_type               = "t3.large"
key_pair                    = "prod-idm-engine-pem"
associate_public_ip_address = false
monitoring                  = true
storage                     = "100"
source_security_group_id    = "sg-0303ee9e9299de168"
vpc_cidr_block              = "10.197.0.0/16"
