# Lookup a recent Amazon Linux 2 AMI (region follows provider configuration)
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  # AMI determined via data source (avoids hardcoding region-specific AMI IDs)
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"

  # Subnet and security group come from the remote state outputs (no hardcoding).
  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]

  tags = {
    Terraform = "true"
    Project   = var.project_id
    # helpful name for identification
    Name      = "${var.project_id}-instance"
  }
}
