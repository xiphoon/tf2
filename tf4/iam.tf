provider "aws" {
  region = var.aws_region
}

locals {
  tags = {
    Project = var.project
  }
}

resource "aws_iam_group" "group" {
  name = var.iam_group_name
  tags = local.tags
}

resource "aws_iam_policy" "s3_write_policy" {
  name        = var.iam_policy_name
  description = "Grants write-only access to specified S3 bucket objects."
  policy      = templatefile("${path.module}/policy.json", { bucket = var.s3_bucket_name })
  tags        = local.tags
}

resource "aws_iam_role" "role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.role.name
  tags = local.tags
}
