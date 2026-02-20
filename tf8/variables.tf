###################################################
# variables.tf
# Input variable definitions
###################################################

variable "aws_region" {
  description = "AWS region where infrastructure will be deployed"
  type        = string
}

variable "ami_id" {
  description = "Amazon Machine Image ID used for EC2 instances"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair used for EC2 instances"
  type        = string
}

variable "vpc_id" {
  description = "ID of the pre-provisioned VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for Application Load Balancer"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for Auto Scaling Group instances"
  type        = list(string)
}

variable "output_bucket_name" {
  description = "Name of the S3 bucket where instance-generated files will be uploaded"
  type        = string
}
