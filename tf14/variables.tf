variable "project_prefix" {
  description = "Prefix used to name resources (e.g. cmtr-0iy36mkm). Use a short stable identifier."
  type        = string
  default     = "cmtr-0iy36mkm"
}

variable "region" {
  description = "AWS region to target."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets (one per AZ)."
  type        = list(string)
  default     = ["10.10.1.0/24", "10.10.3.0/24", "10.10.5.0/24"]
}

variable "azs" {
  description = "Availability zones to create subnets in (one per public subnet)."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "allowed_ip_range" {
  description = "List of IP/CIDR ranges allowed for SSH/HTTP access (non-sensitive). Set this in terraform.tfvars."
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID to use for instances. Provide a region-appropriate AMI in terraform.tfvars."
  type        = string
}
