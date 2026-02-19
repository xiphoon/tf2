variable "project_id" {
  description = "Project identifier used for tags and resource names (e.g. cmtr-0iy36mkm). Provide this in terraform.tfvars."
  type        = string
}

variable "allowed_ip_range" {
  description = "List of CIDR blocks allowed to access security group ingress (e.g. ['18.153.146.156/32','203.0.113.25/32']). Provide this in terraform.tfvars."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the existing VPC (provided by the platform)."
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the pre-created public subnet (provided by the platform)."
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the pre-created private subnet (provided by the platform)."
  type        = string
}

variable "public_instance_id" {
  description = "ID of the existing public EC2 instance (provided by the platform)."
  type        = string
}

variable "private_instance_id" {
  description = "ID of the existing private EC2 instance (provided by the platform)."
  type        = string
}
