locals { project = var.project_id ssh_sg_name = "${local.project}-ssh-sg" public_http_sg_name = "${local.project}-public-http-sg" private_http_sg_name = "${local.project}-private-http-sg" }

Lookup instances

data "aws_instance" "public_instance" { instance_id = var.public_instance_id }

data "aws_instance" "private_instance" { instance_id = var.private_instance_id }

---------------- SSH Security Group ----------------

resource "aws_security_group" "ssh" { name = local.ssh_sg_name description = "SSH access security group" vpc_id = var.vpc_id egress = []

tags = { Project = var.project_id Name = local.ssh_sg_name } }

resource "aws_security_group_rule" "ssh_ingress_ssh" { type = "ingress" from_port = 22 to_port = 22 protocol = "tcp" cidr_blocks = var.allowed_ip_range security_group_id = aws_security_group.ssh.id }

resource "aws_security_group_rule" "ssh_ingress_icmp" { type = "ingress" from_port = -1 to_port = -1 protocol = "icmp" cidr_blocks = var.allowed_ip_range security_group_id = aws_security_group.ssh.id }

resource "aws_security_group_rule" "ssh_egress_all" { type = "egress" from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] security_group_id = aws_security_group.ssh.id }

---------------- Public HTTP Security Group ----------------

resource "aws_security_group" "public_http" { name = local.public_http_sg_name description = "Public HTTP security group" vpc_id = var.vpc_id egress = []

tags = { Project = var.project_id Name = local.public_http_sg_name } }

resource "aws_security_group_rule" "public_http_ingress_http" { type = "ingress" from_port = 80 to_port = 80 protocol = "tcp" cidr_blocks = var.allowed_ip_range security_group_id = aws_security_group.public_http.id }

resource "aws_security_group_rule" "public_http_ingress_icmp" { type = "ingress" from_port = -1 to_port = -1 protocol = "icmp" cidr_blocks = var.allowed_ip_range security_group_id = aws_security_group.public_http.id }

resource "aws_security_group_rule" "public_http_egress_all" { type = "egress" from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] security_group_id = aws_security_group.public_http.id }

---------------- Private HTTP Security Group ----------------

resource "aws_security_group" "private_http" { name = local.private_http_sg_name description = "Private HTTP security group" vpc_id = var.vpc_id egress = []

tags = { Project = var.project_id Name = local.private_http_sg_name } }

resource "aws_security_group_rule" "private_http_ingress_http" { type = "ingress" from_port = 8080 to_port = 8080 protocol = "tcp" source_security_group_id = aws_security_group.public_http.id security_group_id = aws_security_group.private_http.id }

resource "aws_security_group_rule" "private_http_ingress_icmp" { type = "ingress" from_port = -1 to_port = -1 protocol = "icmp" source_security_group_id = aws_security_group.public_http.id security_group_id = aws_security_group.private_http.id }

resource "aws_security_group_rule" "private_http_egress_all" { type = "egress" from_port = 0 to_port = 0 protocol = "-1" cidr_blocks = ["0.0.0.0/0"] security_group_id = aws_security_group.private_http.id }

---------------- Security Group Attachments ----------------

resource "aws_network_interface_sg_attachment" "public_instance_ssh" { network_interface_id = data.aws_instance.public_instance.network_interface_id security_group_id = aws_security_group.ssh.id }

resource "aws_network_interface_sg_attachment" "public_instance_http" { network_interface_id = data.aws_instance.public_instance.network_interface_id security_group_id = aws_security_group.public_http.id }

resource "aws_network_interface_sg_attachment" "private_instance_ssh" { network_interface_id = data.aws_instance.private_instance.network_interface_id security_group_id = aws_security_group.ssh.id }

resource "aws_network_interface_sg_attachment" "private_instance_http" { network_interface_id = data.aws_instance.private_instance.network_interface_id security_group_id = aws_security_group.private_http.id }
