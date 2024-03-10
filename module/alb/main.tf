provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "myalb_vpc" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.myalb_vpc.id
  cidr_block        = var.public1_cidr_block
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.myalb_vpc.id
  cidr_block        = var.public2_cidr_block
  availability_zone = "ap-southeast-1b"
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myalb_vpc.id
}

# Route Table
resource "aws_route_table" "myalb_vpc" {
  vpc_id = aws_vpc.myalb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Application Load Balancer
resource "aws_lb" "test1-unique" {
  name     = "test-alb-unique"
  internal = false
  subnets  = [aws_subnet.public1.id, aws_subnet.public2.id]
}

# Target Group
resource "aws_lb_target_group" "app_tg" {
  name        = "test-alb-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.myalb_vpc.id

  health_check {
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
    path                = var.health_check_path
    port                = var.health_check_port
  }
}

# Listener
resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.test1-unique.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
