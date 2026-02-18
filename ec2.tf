# look up a recent Amazon Linux 2 AMI (resolved at plan/apply time)
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# find a subnet in the target VPC (uses the VPC identifier you provided)
data "aws_subnet_ids" "vpc_subnets" {
  vpc_id = "cmtr-0iy36mkm-vpc"
}

# look up the existing security group by group-name
data "aws_security_group" "cmtr_sg" {
  filter {
    name   = "group-name"
    values = ["cmtr-0iy36mkm-sg"]
  }
}

resource "aws_instance" "cmtr_0iy36mkm_ec2" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.cmtr_0iy36mkm_keypair.key_name
  subnet_id              = element(data.aws_subnet_ids.vpc_subnets.ids, 0)
  vpc_security_group_ids = [data.aws_security_group.cmtr_sg.id]

  tags = {
    Name    = "cmtr-0iy36mkm-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-0iy36mkm"
  }
}

output "ec2_instance_id" {
  value = aws_instance.cmtr_0iy36mkm_ec2.id
}

output "ec2_public_ip" {
  value = aws_instance.cmtr_0iy36mkm_ec2.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.cmtr_0iy36mkm_ec2.public_dns
}
