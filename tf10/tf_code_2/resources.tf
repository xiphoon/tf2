resource "aws_iam_policy" "custom_policy" {
  name        = local.policy_name
  description = var.policy_description

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "*"
    }
  ]
}
EOF

  tags = local.common_tags
}
