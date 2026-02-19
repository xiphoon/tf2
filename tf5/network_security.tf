locals {
}

resource "aws_security_group_rule" "private_http_ingress_http" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_security_group_rule" "private_http_ingress_icmp" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http.id
  security_group_id        = aws_security_group.private_http.id
}

resource "aws_security_group_rule" "private_http_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_http.id
}

# ---------------- SG ATTACHMENTS ----------------
resource "aws_network_interface_sg_attachment" "public_instance_ssh" {
  network_interface_id = data.aws_instance.public_instance.network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "public_instance_http" {
  network_interface_id = data.aws_instance.public_instance.network_interface_id
  security_group_id    = aws_security_group.public_http.id
}

resource "aws_network_interface_sg_attachment" "private_instance_ssh" {
  network_interface_id = data.aws_instance.private_instance.network_interface_id
  security_group_id    = aws_security_group.ssh.id
}

resource "aws_network_interface_sg_attachment" "private_instance_http" {
  network_interface_id = data.aws_instance.private_instance.network_interface_id
  security_group_id    = aws_security_group.private_http.id
}
