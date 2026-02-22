locals {
  common_tags = {
    ManagedBy = "terraform"
    Project   = "blue-green-lab"
    Prefix    = var.name_prefix
  }

  alb_name       = "${var.name_prefix}-lb"
  blue_tg_name   = "${var.name_prefix}-blue-tg"
  green_tg_name  = "${var.name_prefix}-green-tg"
  blue_lt_name   = "${var.name_prefix}-blue-template"
  green_lt_name  = "${var.name_prefix}-green-template"
  blue_asg_name  = "${var.name_prefix}-blue-asg"
  green_asg_name = "${var.name_prefix}-green-asg"
}
