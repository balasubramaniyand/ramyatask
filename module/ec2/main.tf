# Configure AWS provider
provider "aws" {
  region = "ap-southeast-1" # Replace with your desired region
}

# Create a security group to allow access to port 80 (HTTP)
resource "aws_security_group" "my-sg" {
  name        = "web__dadg"
  description = "Security group for web server"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow access from anywhere (adjust for production)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic (adjust for production)
  }
}

# Create an EC2 instance with the latest Amazon Linux 2 image
resource "aws_instance" "my-dad" {
  ami           = "ami-0eb4694aa6f249c52" # Replace with the latest Amazon Linux 2 AMI
  instance_type = "t2.micro" # Adjust instance type based on your needs

  # User data script to install and configure Apache and WordPress
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd php php-mysql -y

    # Install PHP 7.3 for WordPress compatibility
    amazon-linux-extras install -y php7.3

    systemctl enable httpd
    systemctl start httpd

    cd /var/www/html

    echo "healthy" > healthy.html

    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* /var/www/html/
    rm -rf wordpress
    rm -rf latest.tar.gz

    # Restrict file permissions for security (adjust as needed)
    chown -R apache:apache /var/www/html/wp-content
    chmod -R 755 /var/www/html/wp-content

    # (Optional) Secure WordPress installation with additional steps
    # - Create a strong database password and database user
    # - Configure WordPress security plugins
  EOF

  tags = {
    Name = "wordpress"
  }
}
