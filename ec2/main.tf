# Configure AWS Provider
provider "aws" {
  region = "var.aws_region" # Replace with your desired region
}

# VPC Setup (Optional, replace with your existing VPC ID if one exists)
resource "aws_vpc" "my_vpc" {
  cidr_block = "var.vpc_cidr_block"
}

# Subnet Setup (Optional, replace with your existing subnet ID if one exists)
resource "aws_subnet" "public" {
  vpc_id           = aws_vpc.my_vpc.id # Assuming you created a VPC
  cidr_block       = "var.public_subnet_cidr_block"
  availability_zone = "var.availability_zone" # Replace with your desired AZ
}

# Security Group for EC2 Instance
resource "aws_security_group" "web_server" {
  name = "web-server-sg"
  description = "Security group for web server instance"

  ingress {
    from_port = 22
    to_port   = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (for now)
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere (for now)
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# EC2 Instance Creation
resource "aws_instance" "wordpress" {
  ami           = "var.ami_id"
  instance_type = "var.instance_type" # Replace with your desired instance type
  vpc_security_group_ids = [aws_security_group.var.security_group_name.id]
  subnet_id     = aws_subnet.var.public_subnet_cidr_block.id

  

  tags = {
    Name = "wordpress"
  }
}
