provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "my_vpc"{
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "the-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "ap-south-1a"
  depends_on = [aws_vpc.my_vpc]

  tags = {
    Name = "my-subnet"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [aws_subnet.my_subnet]

  tags = {
    Name = "my_igw"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  depends_on = [aws_internet_gateway.my_igw]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
  depends_on = [aws_route_table.my_route_table]
}
