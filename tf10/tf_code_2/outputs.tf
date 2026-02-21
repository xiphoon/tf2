output "custom_policy_arn" {
  description = "ARN of the custom IAM policy moved into tf_code_2"
  value       = aws_iam_policy.custom_policy.arn
  depends_on  = [aws_iam_policy.custom_policy]
}
