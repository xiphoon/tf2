###################################################
# terraform.tfvars
# Non-sensitive input values
###################################################

aws_region = "us-east-1"

ami_id = "ami-09e6f87a47903347c"

ssh_key_name = "cmtr-0iy36mkm-keypair"

vpc_id = "vpc-046163238890c73ae"

public_subnet_ids = [
  "subnet-07ff049bd59e3e8f4",
  "subnet-0a6049b3c61cf8aba"
]

private_subnet_ids = [
  "subnet-02d24924c0aa4b29f",
  "subnet-0a573c475b7af97d4"
]

output_bucket_name = "your-output-bucket-name"
