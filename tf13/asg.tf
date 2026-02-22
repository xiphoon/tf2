resource "aws_autoscaling_group" "blue" {
  name                      = local.blue_asg_name
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.public_subnet_ids
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.blue.id
    version = "\$Latest"
  }

  target_group_arns = [aws_lb_target_group.blue.arn]

  tag {
    key                 = "Name"
    value               = local.blue_asg_name
    propagate_at_launch = true
  }

  tags = [for k, v in local.common_tags : {
    key                 = k
    value               = v
    propagate_at_launch = true
  }]
}

resource "aws_autoscaling_group" "green" {
  name                      = local.green_asg_name
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.public_subnet_ids
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.green.id
    version = "\$Latest"
  }

  target_group_arns = [aws_lb_target_group.green.arn]

  tag {
    key                 = "Name"
    value               = local.green_asg_name
    propagate_at_launch = true
  }

  tags = [for k, v in local.common_tags : {
    key                 = k
    value               = v
    propagate_at_launch = true
  }]
}
