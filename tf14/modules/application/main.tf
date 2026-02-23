locals {
  name_prefix = var.project_prefix
}

resource "aws_launch_template" "app" {
  name_prefix   = "${local.name_prefix}-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  network_interfaces {
    delete_on_termination = true
    security_groups       = [var.ssh_sg_id, var.private_http_sg_id]
  }

  user_data = base64encode(<<-EOF
  #!/bin/bash
  set -e
  
  # Install Apache
  if command -v yum >/dev/null 2>&1; then
    yum update -y
    yum install -y httpd
    systemctl enable httpd
    systemctl start httpd
    WEBROOT="/var/www/html"
  elif command -v apt-get >/dev/null 2>&1; then
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
    WEBROOT="/var/www/html"
  else
    WEBROOT="/tmp"
  fi
  
  # Wait for server to be ready
  sleep 10
  
  # Get instance metadata
  COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
  COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
  
  # Write HTML page
  cat > $${WEBROOT}/index.html <<HTML
  <html>
    <head><title>Instance Info</title></head>
    <body>
      <h1>Instance Info</h1>
      <p>This message was generated on instance $${COMPUTE_INSTANCE_ID} with the following UUID $${COMPUTE_MACHINE_UUID}</p>
    </body>
  </html>
  HTML
  
  # Ensure proper permissions
  chmod 644 $${WEBROOT}/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${local.name_prefix}-instance"
    }
  }
}

resource "aws_lb" "app" {
  name               = "${local.name_prefix}-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.public_http_sg_id]

  tags = {
    Name = "${local.name_prefix}-lb"
  }
}

resource "aws_lb_target_group" "app" {
  name        = "${local.name_prefix}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.name_prefix}-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "${local.name_prefix}-asg"
  max_size            = 2
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      target_group_arns,
      load_balancers,
    ]
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  alb_target_group_arn   = aws_lb_target_group.app.arn
}
