provider "aws" {
  region = "us-east-1"
}

# S3 bucket for project cmtr-0iy36mkm
resource "aws_s3_bucket" "cmtr_bucket" {
  bucket = "cmtr-0iy36mkm-bucket-1771524368"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Project = "cmtr-0iy36mkm"
  }
}

# Block public access on the bucket (recommended)
resource "aws_s3_bucket_public_access_block" "cmtr_bucket_block" {
  bucket = aws_s3_bucket.cmtr_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
