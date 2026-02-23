variable "project_prefix" {
  description = "Prefix used to name resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be created."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ALB and ASG (public subnets)."
  type        = list(string)
}

variable "ssh_sg_id" {
  description = "Security group ID for SSH access to instances."
  type        = string
}

variable "public_http_sg_id" {
  description = "Security group ID to attach to the ALB (public HTTP)."
  type        = string
}

variable "private_http_sg_id" {
  description = "Security group ID for instances to allow HTTP from ALB."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for ASG instances."
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID to use for launching instances (required)."
  type        = string
}
