# AWS Region
region = "us-east-1"

# Common prefix for all resources
name_prefix = "cmtr-0iy36mkm"

# Pre-provisioned VPC
vpc_id = "vpc-04a1b214be4a39fa8"

# Public subnets (cmtr-0iy36mkm-public-subnet1 / subnet2)
public_subnet_ids = [
  "subnet-01cb42480e259f229",
  "subnet-0193fc2dad01a26f7"
]

# Security Groups
# cmtr-0iy36mkm-sg-lb
sg_lb_id = "sg-0060cd70e7c577a51"

# cmtr-0iy36mkm-sg-http
sg_http_id = "sg-07c2cef5e340e980f"

# cmtr-0iy36mkm-sg-ssh
sg_ssh_id = "sg-07c2cef5e340e980f"

# AMI (use Amazon Linux 2023 or Amazon Linux 2 in your region)
ami_id = "ami-0f3caa1cf4417e51b"

# Optional SSH key (leave empty if not required)
key_name = ""

# Auto Scaling configuration
min_size         = 1
max_size         = 2
desired_capacity = 2

# Traffic weights (initially 100% Blue)
blue_weight  = 100
green_weight = 0
