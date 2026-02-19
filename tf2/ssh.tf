# provider declaration (optional if you already have provider config elsewhere)
provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "cmtr_0iy36mkm_keypair" {
  key_name   = "cmtr-0iy36mkm-keypair"
  public_key = var.ssh_key

  tags = {
    Project = "epam-tf-lab"
    ID      = "cmtr-0iy36mkm"
  }
}
