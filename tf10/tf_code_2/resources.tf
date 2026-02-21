resource "aws_iam_policy" "custom_policy" {
  name        = local.policy_name
  description = var.policy_description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3List"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
        ]
        Resource = ["*"]
      }
    ]
  })

  tags = local.common_tags
}
