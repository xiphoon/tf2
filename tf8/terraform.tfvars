###################################################
# terraform.tfvars
# Non-sensitive input values
###################################################

aws_region = "us-east-1"

ami_id = "ami-09e6f87a47903347c"

ssh_key_name = "cmtr-0iy36mkm-keypair"

vpc_id = "vpc-xxxxxxxx"

public_subnet_ids = [
  "subnet-xxxxxxxx",
  "subnet-yyyyyyyy"
]

private_subnet_ids = [
  "subnet-aaaaaaaa",
  "subnet-bbbbbbbb"
]

output_bucket_name = "your-output-bucket-name"
