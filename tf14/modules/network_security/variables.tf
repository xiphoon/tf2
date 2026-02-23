variable "project_prefix" {
  description = "Prefix used to name resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where security groups will be created."
  type        = string
}

variable "allowed_ip" {
  description = "List of CIDR ranges allowed to access SSH/HTTP (e.g. [\"18.153.146.156/32\",\"203.0.113.25/32\"])."
  type        = list(string)
}
