output "iam_role_arn" {
  description = "ARN of the IAM role created for EC2."
  value       = aws_iam_role.role.arn
}

output "iam_policy_arn" {
  description = "ARN of the custom IAM policy granting write access to the S3 bucket."
  value       = aws_iam_policy.s3_write_policy.arn
}

output "iam_instance_profile_name" {
  description = "Name of the IAM instance profile."
  value       = aws_iam_instance_profile.instance_profile.name
}

output "iam_group_name" {
  description = "Name of the IAM group created."
  value       = aws_iam_group.group.name
}
