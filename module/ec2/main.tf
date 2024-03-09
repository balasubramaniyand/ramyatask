# Configure AWS Provider
provider "aws" {
  region = var.aws_region # Replace with your desired region
}

# VPC Setup (Optional, replace with your existing VPC ID if one exists)
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

# Subnet Setup (Optional, replace with your existing subnet ID if one exists)
resource "aws_subnet" "public" {
  vpc_id           = aws_vpc.my_vpc.id # Assuming you created a VPC
  cidr_block       = var.public_subnet_cidr_block
  availability_zone = var.availability_zone # Replace with your desired AZ
}

# Security Group for EC2 Instance
resource "aws_security_group" "web_server" {
  name        = "web-server-sg" # Replace with a meaningful name for your security group
  description = "Security group for web server instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (for now)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere (for now)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

# EC2 Instance Creation
resource "aws_instance" "wordpress" {
  ami                    = var.ami_id
  instance_type          = var.instance_type # Replace with your desired instance type
  vpc_security_group_ids = [aws_security_group.web_server.id]
  subnet_id              = aws_subnet.public.id
  key_name               = "7" 
  
  root_block_device {
    volume_size           = 8    # Specify the desired size of the EBS volume
    volume_type           = "gp2" # Specify the type of EBS volume (e.g., gp2, io1)
    delete_on_termination = true  # Specify whether the EBS volume should be deleted when the instance is terminated
  }

  user_data = <<-EOF
#!/bin/bash
yum install httpd php-mysql -y
amazon-linux-extras install -y php7.3
cd /var/www/html
echo "healthy" > healthy.html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz 
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf latest.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content
wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
mv htaccess.txt .htaccess
chkconfig httpd on
service httpd start
EOF

  tags = {
    Name = "wordpress"
  }
}
