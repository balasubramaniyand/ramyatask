variable "aws_region" {
  type = string
  description = "The AWS region to deploy the resources in."
  default = "ap-southeast-1"  # Match the region in your main.tf configuration
}

variable "instance_type" {
  type = string
  description = "The instance type for the EC2 instance."
  default = "t2.micro"
}

variable "ami_id" {
  type = string
  description = "The AMI ID to use for the EC2 instance."
  default = "ami-0eb4694aa6f249c52"
}

variable "security" {
  type = string
  description = "The name of the security group for the EC2 instance."
  default = "web-server-sg"
}
