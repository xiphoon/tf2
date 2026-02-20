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

# Find subnet ids in the VPC that match the public subnet name tag
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = var.public_subnet_name
  }
}

# Select the first matching subnet (should be the public subnet provided)
data "aws_subnet" "public" {
  id = element(data.aws_subnet_ids.public.ids, 0)
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
