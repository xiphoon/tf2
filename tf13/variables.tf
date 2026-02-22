variable "region" {
  description = "AWS region to deploy into."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used to build resource names (e.g. cmtr-0iy36mkm)."
  type        = string
}

variable "vpc_id" {
  description = "VPC id where resources will be created."
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet ids for the ALB and instances."
  type        = list(string)
}

variable "sg_lb_id" {
  description = "Security Group id for the ALB."
  type        = string
}

variable "sg_http_id" {
  description = "Security Group id for HTTP access to EC2 instances."
  type        = string
}

variable "sg_ssh_id" {
  description = "Security Group id for SSH access to EC2 instances."
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access."
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "AMI id to use for Launch Templates."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum size for each ASG."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size for each ASG."
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired capacity for each ASG."
  type        = number
}

variable "blue_weight" {
  description = "Traffic weight for Blue target group."
  type        = number
  default     = 100
}

variable "green_weight" {
  description = "Traffic weight for Green target group."
  type        = number
  default     = 0
}
