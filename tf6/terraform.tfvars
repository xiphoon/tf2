aws_region            = "us-east-1"
environment           = "lab"
tags = {
  Owner = "student"
  Project = "network-lab"
}

vpc_name              = "lab-vpc"
vpc_cidr              = "10.0.0.0/16"

subnet1_name          = "public-subnet-1"
subnet1_cidr          = "10.0.1.0/24"
availability_zone1    = "us-east-1a"

subnet2_name          = "public-subnet-2"
subnet2_cidr          = "10.0.2.0/24"
availability_zone2    = "us-east-1b"

subnet3_name          = "public-subnet-3"
subnet3_cidr          = "10.0.3.0/24"
availability_zone3    = "us-east-1c"

internet_gateway_name = "lab-igw"
routing_table_name    = "lab-public-rt"
