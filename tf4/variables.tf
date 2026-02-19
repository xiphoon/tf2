variable "aws_region" {
  description = "AWS region to deploy resources into."
  type        = string
}

variable "project" {
  description = "Project tag value (Project)."
  type        = string
}

variable "s3_bucket_name" {
  description = "Existing S3 bucket name to which the IAM policy will grant write access."
  type        = string
}

variable "iam_group_name" {
  description = "Name for the IAM group."
  type        = string
}

variable "iam_policy_name" {
  description = "Name for the custom IAM policy."
  type        = string
}

variable "iam_role_name" {
  description = "Name for the IAM role to be assumed by EC2."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "Name for the IAM instance profile."
  type        = string
}
