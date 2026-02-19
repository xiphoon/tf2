locals {
  # Build a map of the three public subnets so resources can be generated dynamically
  public_subnets = {
    subnet1 = {
      name = var.subnet1_name
      az   = var.availability_zone1
      cidr = var.subnet1_cidr
    }
    subnet2 = {
      name = var.subnet2_name
      az   = var.availability_zone2
      cidr = var.subnet2_cidr
    }
    subnet3 = {
      name = var.subnet3_name
      az   = var.availability_zone3
      cidr = var.subnet3_cidr
    }
  }

  combined_tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(local.combined_tags, {
    Name = var.vpc_name
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.combined_tags, {
    Name = var.internet_gateway_name
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.combined_tags, {
    Name = var.routing_table_name
  })
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(local.combined_tags, {
    Name = each.value.name
  })
}

resource "aws_route_table_association" "public_assoc" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
