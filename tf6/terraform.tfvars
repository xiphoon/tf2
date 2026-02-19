aws_region            = "us-east-1"
environment           = "lab"
tags = {
  Owner   = "student"
  Project = "network-lab"
}

vpc_name              = "cmtr-0iy36mkm-01-vpc"
vpc_cidr              = "10.10.0.0/16"

subnet1_name          = "cmtr-0iy36mkm-01-subnet-public-a"
subnet1_cidr          = "10.10.1.0/24"
availability_zone1    = "us-east-1a"

subnet2_name          = "cmtr-0iy36mkm-01-subnet-public-b"
subnet2_cidr          = "10.10.3.0/24"
availability_zone2    = "us-east-1b"

subnet3_name          = "cmtr-0iy36mkm-01-subnet-public-c"
subnet3_cidr          = "10.10.5.0/24"
availability_zone3    = "us-east-1c"

internet_gateway_name = "cmtr-0iy36mkm-01-igw"
routing_table_name    = "cmtr-0iy36mkm-01-rt"
