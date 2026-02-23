locals {
  name_prefix = var.project_prefix
}

resource "aws_security_group" "ssh" {
  name   = "${local.name_prefix}-ssh-sg"
  vpc_id = var.vpc_id
  description = "SSH SG"

  tags = {
    Name = "${local.name_prefix}-ssh-sg"
  }
}

resource "aws_security_group_rule" "ssh_ingress" {
  for_each = toset(var.allowed_ip)

  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = [each.value]
  security_group_id        = aws_security_group.ssh.id
  description              = "Allow SSH from allowed IPs"
}

resource "aws_security_group" "public_http" {
  name        = "${local.name_prefix}-public-http-sg"
  vpc_id      = var.vpc_id
  description = "Public HTTP SG"

  tags = {
    Name = "${local.name_prefix}-public-http-sg"
  }
}

resource "aws_security_group_rule" "public_http_ingress" {
  for_each = toset(var.allowed_ip)

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.public_http.id
  description       = "Allow HTTP from allowed IPs"
}

resource "aws_security_group" "private_http" {
  name        = "${local.name_prefix}-private-http-sg"
  vpc_id      = var.vpc_id
  description = "Private HTTP SG for app instances (only allow from public-http SG)"
  tags = {
    Name = "${local.name_prefix}-private-http-sg"
  }
}

resource "aws_security_group_rule" "private_http_from_public_sg" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.private_http.id
  source_security_group_id = aws_security_group.public_http.id
  description              = "Allow HTTP from public HTTP SG"
}
