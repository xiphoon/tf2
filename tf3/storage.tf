############################################
# Variables
############################################

variable "aws_region" {
  description = "AWS region where all resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket used to store project data."
  type        = string
  default     = "cmtr-0iy36mkm-bucket-1771524368"
}

############################################
# Provider
############################################

provider "aws" {
  region = var.aws_region
}

############################################
# S3 Bucket
############################################

resource "aws_s3_bucket" "cmtr_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "cmtr-0iy36mkm"
  }
}

# Block public access on the bucket (recommended best practice)
resource "aws_s3_bucket_public_access_block" "cmtr_bucket_block" {
  bucket = aws_s3_bucket.cmtr_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
