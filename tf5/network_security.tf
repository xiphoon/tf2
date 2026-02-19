locals {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_http.id
  description       = "Allow all outbound"
}

# Private HTTP Security Group
resource "aws_security_group" "private_http" {
  name        = local.private_http_sg_name
  description = "Private HTTP security group for ${local.project}"
  vpc_id      = var.vpc_id

  tags = {
    Project = var.project_id
    Name    = local.private_http_sg_name
  }
}

# Allow TCP 8080 from the public HTTP security group
resource "aws_security_group_rule" "private_http_ingress_from_public_http" {
  type                       = "ingress"
  from_port                  = 8080
  to_port                    = 8080
  protocol                   = "tcp"
  source_security_group_id   = aws_security_group.public_http.id
  security_group_id          = aws_security_group.private_http.id
  description                = "Allow HTTP 8080 from public HTTP SG"
}

# Allow ICMP from the public HTTP security group
resource "aws_security_group_rule" "private_http_ingress_icmp_from_public" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
  description              = "Allow ICMP from public HTTP SG"
}

resource "aws_security_group_rule" "private_http_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_http.id
  description       = "Allow all outbound"
}

# Attach security groups to instances via their primary network interface
resource "aws_network_interface_sg_attachment" "public_instance_ssh" {
  network_interface_id = data.aws_instance.public_instance.primary_network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "public_instance_public_http" {
  network_interface_id = data.aws_instance.public_instance.primary_network_interface_id
  security_group_id    = aws_security_group.public_http.id
}

resource "aws_network_interface_sg_attachment" "private_instance_ssh" {
  network_interface_id = data.aws_instance.private_instance.primary_network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "private_instance_private_http" {
  network_interface_id = data.aws_instance.private_instance.primary_network_interface_id
  security_group_id    = aws_security_group.private_http.id
}
