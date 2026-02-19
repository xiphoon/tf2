locals {
  # Names are generated using project_id to avoid hardcoding
  ssh_sg_name          = "${var.project_id}-ssh-sg"
  public_http_sg_name  = "${var.project_id}-public-http-sg"
  private_http_sg_name = "${var.project_id}-private-http-sg"

  tags = {
    Project = var.project_id
  }
}

#
# SSH Security Group
#
resource "aws_security_group" "ssh" {
  name        = local.ssh_sg_name
  description = "SSH access for ${var.project_id}"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, { Name = local.ssh_sg_name })
}

resource "aws_security_group_rule" "ssh_ingress_ssh" {
  description       = "Allow SSH from allowed_ip_range"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "ssh_ingress_icmp" {
  description       = "Allow ICMP (all types) from allowed_ip_range"
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "ssh_egress_all" {
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh.id
}

#
# Public HTTP Security Group (port 80)
#
resource "aws_security_group" "public_http" {
  name        = local.public_http_sg_name
  description = "Public HTTP security group for ${var.project_id}"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, { Name = local.public_http_sg_name })
}

resource "aws_security_group_rule" "public_http_ingress_http" {
  description       = "Allow HTTP (80) from allowed_ip_range"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "public_http_ingress_icmp" {
  description       = "Allow ICMP (all types) from allowed_ip_range"
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.public_http.id
}

resource "aws_security_group_rule" "public_http_egress_all" {
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_http.id
}

#
# Private HTTP Security Group (port 8080) - ingress from Public HTTP SG
#
resource "aws_security_group" "private_http" {
  name        = local.private_http_sg_name
  description = "Private HTTP (8080) for ${var.project_id}; accepts traffic from public HTTP SG"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, { Name = local.private_http_sg_name })
}

resource "aws_security_group_rule" "private_http_ingress_from_public_http" {
  description              = "Allow HTTP (8080) from public HTTP security group"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_security_group_rule" "private_http_ingress_icmp_from_public" {
  description              = "Allow ICMP from public HTTP security group"
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_security_group_rule" "private_http_egress_all" {
  description       = "Allow all outbound"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_http.id
}

#
# Network Interface Data Sources (primary interfaces)
#
data "aws_network_interface" "public_primary" {
  filter {
    name   = "attachment.instance-id"
    values = [var.public_instance_id]
  }

  filter {
    name   = "attachment.device-index"
    values = ["0"]
  }
}

data "aws_network_interface" "private_primary" {
  filter {
    name   = "attachment.instance-id"
    values = [var.private_instance_id]
  }

  filter {
    name   = "attachment.device-index"
    values = ["0"]
  }
}

#
# Attach security groups to EC2 instances
#
resource "aws_network_interface_sg_attachment" "public_attach_ssh" {
  network_interface_id = data.aws_network_interface.public_primary.id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "public_attach_http" {
  network_interface_id = data.aws_network_interface.public_primary.id
  security_group_id    = aws_security_group.public_http.id
}

resource "aws_network_interface_sg_attachment" "private_attach_ssh" {
  network_interface_id = data.aws_network_interface.private_primary.id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "private_attach_private_http" {
  network_interface_id = data.aws_network_interface.private_primary.id
  security_group_id    = aws_security_group.private_http.id
}
