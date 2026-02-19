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
  description = "CIDR block for the VPC."
  type        = string
}

# Public subnet A
variable "subnet1_name" {
  description = "Name tag for public subnet A."
  type        = string
}
variable "subnet1_cidr" {
  description = "CIDR block for public subnet A."
  type        = string
}
variable "availability_zone1" {
  description = "Availability Zone for public subnet A."
  type        = string
}

# Public subnet B
variable "subnet2_name" {
  description = "Name tag for public subnet B."
  type        = string
}
variable "subnet2_cidr" {
  description = "CIDR block for public subnet B."
  type        = string
}
variable "availability_zone2" {
  description = "Availability Zone for public subnet B."
  type        = string
}

# Public subnet C
variable "subnet3_name" {
  description = "Name tag for public subnet C."
  type        = string
}
variable "subnet3_cidr" {
  description = "CIDR block for public subnet C."
  type        = string
}
variable "availability_zone3" {
  description = "Availability Zone for public subnet C."
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
