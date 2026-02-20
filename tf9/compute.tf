resource "aws_instance" "cmtr_0iy36mkm_instance" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  # Ensure public IP assignment on a public subnet
  associate_public_ip_address = true

  tags = {
    Name    = "${var.project_id}-instance" # cmtr-0iy36mkm-instance
    Project = var.project_id
  }
}
