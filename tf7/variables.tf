variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "project_id" {
  description = "Project identifier for tagging (e.g. cmtr-0iy36mkm)"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket name that stores the remote Terraform state"
  type        = string
}

variable "state_key" {
  description = "S3 key (path) to the remote Terraform state file"
  type        = string
}
