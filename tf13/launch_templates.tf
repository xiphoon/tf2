resource "aws_launch_template" "blue" {
  name_prefix   = local.blue_lt_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = compact([var.sg_http_id, var.sg_ssh_id])
  key_name               = length(var.key_name) > 0 ? var.key_name : null

  user_data = base64encode(<<EOF
#!/bin/bash
set -e

if command -v yum >/dev/null 2>&1; then
  yum update -y
  yum install -y httpd
  systemctl enable httpd
  echo "<html><body><h1>Blue Environment</h1></body></html>" > /var/www/html/index.html
  systemctl start httpd
elif command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y apache2
  systemctl enable apache2
  echo "<html><body><h1>Blue Environment</h1></body></html>" > /var/www/html/index.html
  systemctl start apache2
fi
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common_tags, { Name = local.blue_lt_name })
  }
}

resource "aws_launch_template" "green" {
  name_prefix   = local.green_lt_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = compact([var.sg_http_id, var.sg_ssh_id])
  key_name               = length(var.key_name) > 0 ? var.key_name : null

  user_data = base64encode(<<EOF
#!/bin/bash
set -e

if command -v yum >/dev/null 2>&1; then
  yum update -y
  yum install -y httpd
  systemctl enable httpd
  echo "<html><body><h1>Green Environment</h1></body></html>" > /var/www/html/index.html
  systemctl start httpd
elif command -v apt-get >/dev/null 2>&1; then
  apt-get update -y
  apt-get install -y apache2
  systemctl enable apache2
  echo "<html><body><h1>Green Environment</h1></body></html>" > /var/www/html/index.html
  systemctl start apache2
fi
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags          = merge(local.common_tags, { Name = local.green_lt_name })
  }
}
