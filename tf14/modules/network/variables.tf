variable "project_prefix" {
  description = "Prefix used to name resources."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs (order matches azs)."
  type        = list(string)
}

variable "azs" {
  description = "List of AZs for public subnets (order matches public_subnet_cidrs)."
  type        = list(string)
}
