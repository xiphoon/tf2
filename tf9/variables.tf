variable "aws_region" {
  description = "AWS region for resources."
  type        = string
}

variable "project_id" {
  description = "Project identifier used for tagging (e.g. cmtr-0iy36mkm)."
  type        = string
}

variable "vpc_name" {
  description = "Name tag of the VPC to discover (tag:Name)."
  type        = string
}

variable "public_subnet_name" {
  description = "Name tag of the public subnet to discover (tag:Name)."
  type        = string
}

variable "security_group_name" {
  description = "Name tag of the security group to discover (tag:Name)."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type to provision."
  type        = string
}
