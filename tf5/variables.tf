variable "aws_region" { description = "AWS region to operate in" type = string }

variable "project_id" { description = "Project identifier used for naming and tagging" type = string }

variable "allowed_ip_range" { description = "List of CIDR ranges allowed to access public endpoints" type = list(string) }

variable "vpc_id" { description = "ID of the VPC where security groups will be created" type = string }

variable "public_subnet_id" { description = "ID of the public subnet" type = string }

variable "private_subnet_id" { description = "ID of the private subnet" type = string }

variable "public_instance_id" { description = "EC2 instance ID for the public instance" type = string }

variable "private_instance_id" { description = "EC2 instance ID for the private instance" type = string }
