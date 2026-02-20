provider "aws" {
  region = var.aws_region
}

# Discover VPC by tag:Name
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Find public subnet directly by name tag and VPC
data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

# Find security group by Name tag within the discovered VPC
data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Name"
    values = [var.security_group_name]
  }
}

# Latest Amazon Linux 2023 AMI (x86_64) from Amazon owners
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-linux-2023*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
