variable "aws_region" {
  description = "AWS region where the S3 bucket will be created."
  type        = string
}

variable "project" {
  description = "Project identifier used for tagging and resource naming."
  type        = string
}

variable "bucket_suffix" {
  description = "Unique numeric or string suffix appended to the S3 bucket name to ensure global uniqueness."
  type        = string
}
