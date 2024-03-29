region                      = "us-east-2"
node_count                  = 1
vpc_id                      = "vpc-07b5701b02dd17230"
subnet_id                   = ["subnet-061e9dd32f21d91d7"]
ami_id                      = "ami-03f4c416f489586a3"
instance_type               = "t2.micro"
key_pair                    = "dev-bastion-pem"
associate_public_ip_address = "true"
monitoring                  = "true"
storage                     = "10"
source_security_group_id    = "sg-0af8fa6b796c71e00"
