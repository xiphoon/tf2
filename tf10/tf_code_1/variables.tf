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
