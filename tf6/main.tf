# Provider configuration only. Do NOT configure a backend here per lab requirements.
provider "aws" {
  region = var.aws_region
  # Credentials should be provided via environment variables, shared credentials file, or other supported methods.
}
