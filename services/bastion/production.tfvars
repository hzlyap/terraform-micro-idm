region                      = "us-east-2"
node_count                  = 1
vpc_id                      = "vpc-076449537654b0bf9"
subnet_id                   = ["subnet-0bc7530c730776505","subnet-041fd4c4455b9ac8a"]
ami_id                      = "ami-03f4c416f489586a3"
instance_type               = "t2.micro"
key_pair                    = "prod-bastion-pem"
associate_public_ip_address = true
monitoring                  = true
storage                     = "10"
source_security_group_id    = "sg-0303ee9e9299de168"
