# AWS Region
region = "us-east-1"

# Common prefix for all resources
name_prefix = "cmtr-0iy36mkm"

# Pre-provisioned VPC
vpc_id = "vpc-09e52461da2cfc7e4"

# Public subnets (cmtr-0iy36mkm-public-subnet1 / subnet2)
public_subnet_ids = [
  "subnet-044a34decf0f704d1",
  "subnet-0c48760b1e241410f"
]

# Security Groups
# cmtr-0iy36mkm-sg-lb
sg_lb_id = "sg-0571b8997e9ed4c99"

# cmtr-0iy36mkm-sg-http
sg_http_id = "sg-00e00d861b72f41a6"

# cmtr-0iy36mkm-sg-ssh
sg_ssh_id = "sg-00e00d861b72f41a6"

# AMI (use Amazon Linux 2023 or Amazon Linux 2 in your region)
ami_id = "ami-0123456789abcdef0"

# Optional SSH key (leave empty if not required)
key_name = ""

# Auto Scaling configuration
min_size         = 1
max_size         = 2
desired_capacity = 2

# Traffic weights (initially 100% Blue)
blue_weight  = 100
green_weight = 0
