variable "aws_region" {
  description = "AWS region to deploy resources (example: us-east-1)"
  type        = string
}

variable "environment" {
  description = "Logical environment tag (example: lab, dev, prod)."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to all created resources (non-sensitive)."
  type        = map(string)
}

variable "vpc_name" {
  description = "Name tag for the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (example: 10.0.0.0/16)."
  type        = string
}

# Subnet 1
variable "subnet1_name" {
  description = "Name tag for public subnet 1."
  type        = string
}
variable "subnet1_cidr" {
  description = "CIDR block for public subnet 1."
  type        = string
}
variable "availability_zone1" {
  description = "Availability Zone for public subnet 1 (example: us-east-1a)."
  type        = string
}

# Subnet 2
variable "subnet2_name" {
  description = "Name tag for public subnet 2."
  type        = string
}
variable "subnet2_cidr" {
  description = "CIDR block for public subnet 2."
  type        = string
}
variable "availability_zone2" {
  description = "Availability Zone for public subnet 2 (example: us-east-1b)."
  type        = string
}

# Subnet 3
variable "subnet3_name" {
  description = "Name tag for public subnet 3."
  type        = string
}
variable "subnet3_cidr" {
  description = "CIDR block for public subnet 3."
  type        = string
}
variable "availability_zone3" {
  description = "Availability Zone for public subnet 3 (example: us-east-1c)."
  type        = string
}

variable "internet_gateway_name" {
  description = "Name tag for the Internet Gateway."
  type        = string
}

variable "routing_table_name" {
  description = "Name tag for the public routing table."
  type        = string
}
