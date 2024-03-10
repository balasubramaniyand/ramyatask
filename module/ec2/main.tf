# Configure AWS Provider
provider "aws" {
  region = var.aws_region  # Replace with your desired region
}

# VPC and Subnet (Optional)
# -- Use existing VPC and subnet resources if available
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet1_cidr_block
  availability_zone = var.availability_zone  # Update if needed
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associate Internet Gateway with Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security Group
resource "aws_security_group" "web_server" {
  vpc_id      = aws_vpc.my_vpc.id  # Associate the security group with the same VPC
  name        = "web-server-sg"
  description = "Security group for web server instance"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict SSH access
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Restrict HTTP access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}

# EC2 Instance
resource "aws_instance" "wordpress" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public.id
  key_name        = "7"
  vpc_security_group_ids = [aws_security_group.web_server.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size             = 8
    volume_type             = "gp2"
    delete_on_termination   = true
  }

  user_data = <<-EOF
    #!/bin/bash
    yum install -y httpd php-mysql
    amazon-linux-extras install -y php7.3
    cd /var/www/html
    echo "healthy" > healthy.html
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* /var/www/html/
    rm -rf wordpress latest.tar.gz
    chmod -R 755 wp-content
    chown -R apache:apache wp-content
    wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt -O .htaccess
    systemctl enable httpd
    systemctl start httpd
  EOF

  tags = {
    Name = "wordpress"
  }
}
