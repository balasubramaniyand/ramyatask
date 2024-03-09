variable "aws_region" {
  type = string
  description = "The AWS region to create the VPC in"
  default = "ap-south-1"  # Replace with your desired region
}

variable "vpc_cidr_block" {
  type = string
  description = "The CIDR block for the VPC"
  default = "10.0.0.0/16"  # Replace with your desired CIDR block
}

variable "public_subnet1_cidr_block" {
  type = string
  description = "The CIDR block for public subnet 1"
  default = "10.0.1.0/24"  # Replace with your desired CIDR block
}

variable "public_subnet2_cidr_block" {
  type = string
  description = "The CIDR block for public subnet 2"
  default = "10.0.2.0/24"  # Replace with your desired CIDR block
}
