variable "name_prefix" {
  description = "Prefix used to construct resource names"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev/stage/prod)"
  type        = string
}

variable "owner" {
  description = "Owner tag for resources"
  type        = string
}

variable "policy_description" {
  description = "Description text for the IAM policy"
  type        = string
  default     = "Custom policy for project"
}
