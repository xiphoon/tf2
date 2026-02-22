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
  description = "Security Group id to attach to the ALB (allows HTTP)."
  type        = string
}

variable "sg_http_id" {
  description = "Security Group id to attach to EC2 instances for HTTP access."
  type        = string
}

variable "sg_ssh_id" {
  description = "Security Group id to attach to EC2 instances for SSH access."
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for instance SSH access. Leave empty string if not used."
  type        = string
  default     = ""
}

variable "ami_id" {
  description = "AMI id to use for launch templates (Linux with httpd available)."
  type        = string
}

variable "instance_type" {
  description = "Instance type for ASG Launch Templates."
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum size for each Auto Scaling Group."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size for each Auto Scaling Group."
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired capacity for each Auto Scaling Group."
  type        = number
  default     = 2
}
}
