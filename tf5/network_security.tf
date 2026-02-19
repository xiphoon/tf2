locals {
  project               = var.project_id
  ssh_sg_name           = "${local.project}-ssh-sg"
  public_http_sg_name   = "${local.project}-public-http-sg"
  private_http_sg_name  = "${local.project}-private-http-sg"
}

# Lookup Instances so we can find their primary network interface ids for attachments
data "aws_instance" "public_instance" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private_instance" {
  instance_id = var.private_instance_id
}

# SSH Security Group
resource "aws_security_group" "ssh" {
  name        = local.ssh_sg_name
  description = "SSH access security group for ${local.project}"
  vpc_id      = var.vpc_id

  egress = []

  tags = {
    Project = var.project_id
    Name    = local.ssh_sg_name
  }
}

# Allow SSH from allowed_ip_range
resource "aws_security_group_rule" "ssh_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
  description       = "Allow SSH from allowed ranges"
}

# Allow ICMP from allowed_ip_range
resource "aws_security_group_rule" "ssh_ingress_icmp" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = var.allowed_ip_range
  security_group_id = aws_security_group.ssh.id
  description       = "Allow ICMP from allowed ranges"
}

# Allow all egress from SSH SG
resource "aws_security_group_rule" "ssh_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh.id
  description       = "Allow all outbound"
}

# Public HTTP Security Group
resource "aws_security_group" "public_http" {
  name        = local.public_http_sg_name
  description = "Public HTTP security group for ${local.project}"
  vpc_id      = var.vpc_id

  egress = []

  tags = {
    Project = var.project_id
    Name    = local.public_http_sg_name
  }
}

resource "aws_security_group_rule" "public_http_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}
