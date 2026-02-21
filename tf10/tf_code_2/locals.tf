locals {
  policy_name = "${var.name_prefix}-custom-policy-${var.environment}"
  common_tags = {
    Environment = var.environment
    Owner       = var.owner
  }
}
