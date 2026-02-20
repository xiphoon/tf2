###################################################
# application.tf
# Defines launch template, autoscaling group, ALB, and attachment
# Assumes provider + versions are defined elsewhere (versions.tf / main.tf)
###################################################

locals {
  name_prefix = "cmtr-0iy36mkm"
  common_tags = {
    Terraform = "true"
    Project   = local.name_prefix
  }
}

# === Data sources for pre-provisioned resources ===
data "aws_security_group" "ec2_sg" {
  name = "${local.name_prefix}-ec2_sg"
}

data "aws_security_group" "http_sg" {
  name = "${local.name_prefix}-http_sg"
}

data "aws_security_group" "sglb" {
  name = "${local.name_prefix}-sglb"
}

# === Launch Template ===
resource "aws_launch_template" "cmtr_template" {
  name          = "${local.name_prefix}-template" # generated via locals + required name
  image_id      = var.ami_id                      # ami-09e6f87a47903347c (set in variables.tf/terraform.tfvars)
  instance_type = "t3.micro"
  key_name      = var.ssh_key_name

  iam_instance_profile {
    name = "${local.name_prefix}-instance_profile" # pre-provisioned profile name
  }

  # Network interfaces: attach and ensure delete_on_termination = true
  network_interfaces {
    device_index          = 0
    delete_on_termination = true
    security_groups = [
      data.aws_security_group.ec2_sg.id,
      data.aws_security_group.http_sg.id
    ]
    # associate_public_ip_address can be controlled through var if needed. Leave default (false) unless specified.
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
set -euo pipefail

# Update & install packages
if command -v yum >/dev/null 2>&1; then
  yum update -y
  yum install -y aws-cli httpd jq
  systemctl enable httpd
  systemctl start httpd
elif command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  DEBIAN_FRONTEND=noninteractive apt-get install -y awscli apache2 jq
  systemctl enable apache2
  systemctl start apache2
fi

# Get IMDSv2 token
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -s -H "X-aws-ec2-metadata-token: $${TOKEN}" \
  http://169.254.169.254/latest/meta-data/instance-id)

PRIVATE_IP=$(curl -s -H "X-aws-ec2-metadata-token: $${TOKEN}" \
  http://169.254.169.254/latest/meta-data/local-ipv4 || true)

# Create HTML page
cat > /var/www/html/index.html <<HTML
<!doctype html>
<html>
  <head><title>Instance Info</title></head>
  <body>
    <pre>
This message was generated on instance $${INSTANCE_ID} with the following IP: $${PRIVATE_IP}
    </pre>
  </body>
</html>
HTML

INFO_FILE="/tmp/$${INSTANCE_ID}.txt"

echo "instance_id=$${INSTANCE_ID}" > $${INFO_FILE}
echo "private_ip=$${PRIVATE_IP}" >> $${INFO_FILE}
echo "generated_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)" >> $${INFO_FILE}

aws s3 cp "$${INFO_FILE}" \
"s3://${var.output_bucket_name}/${local.name_prefix}/$${INSTANCE_ID}.txt" \
--only-show-errors || true

EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common_tags, { Name = "${local.name_prefix}-instance" })
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-launch-template" })
}

# === Application Load Balancer ===
resource "aws_lb" "cmtr_alb" {
  name                       = "${local.name_prefix}-loadbalancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [data.aws_security_group.sglb.id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = false

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-alb" })
}

resource "aws_lb_target_group" "cmtr_tg" {
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
    timeout             = 5
  }

  tags = local.common_tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cmtr_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cmtr_tg.arn
  }
}

# === Auto Scaling Group ===
resource "aws_autoscaling_group" "cmtr_asg" {
  name                = "${local.name_prefix}-asg"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 2
  vpc_zone_identifier = var.private_subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.cmtr_template.id
    version = "$Latest"
  }

  # Name tag
  tag {
    key                 = "Name"
    value               = "${local.name_prefix}-instance"
    propagate_at_launch = true
  }

  # Common tags
  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    ignore_changes = [
      target_group_arns,
      load_balancers,
    ]
  }
}

  # Attach via separate attachment resource below (ignore_changes required per task)
  lifecycle {
    ignore_changes = [
      # ignore ASG changes to Load Balancer and target group ARNs
      target_group_arns,
      load_balancers,
    ]
  }

  tags = merge(local.common_tags, { "Name" = "${local.name_prefix}-asg" })

# Attach ASG to the ALB target group using autoscaling attachment resource
resource "aws_autoscaling_attachment" "asg_tg_attach" {
  autoscaling_group_name = aws_autoscaling_group.cmtr_asg.name
  alb_target_group_arns  = [aws_lb_target_group.cmtr_tg.arn]
}

# (Optional) If you also needed to attach a classic ELB it would be:
# elb = aws_elb.classic_elb.id

# === Outputs are intentionally omitted from this file (place outputs in outputs.tf) ===

# End of application.tf
