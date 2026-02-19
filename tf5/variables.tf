variable "aws_region" {
  description = "AWS region to operate in"
  type        = string
}

variable "project_id" {
  description = "Project identifier used for naming and tagging"
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR ranges allowed to access the public endpoints (e.g. [\"1.2.3.4/32\"])"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet (not directly used but captured for completeness)"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet (not directly used but captured for completeness)"
  type        = string
}

variable "public_instance_id" {
  description = "EC2 instance id for the public instance to attach security groups to"
  type        = string
}

variable "private_instance_id" {
  description = "EC2 instance id for the private instance to attach security groups to"
  type        = string
}
