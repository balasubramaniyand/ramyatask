provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "my_sg" {
  name        = var.security_group_name
  description = "Security group for WordPress EC2 instance"

  ingress {
    description = "Allow Port 80"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name = "wordpress-sg"
  }
}