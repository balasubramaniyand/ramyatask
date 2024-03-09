
variable "aws_region" {
    type = string
    default = "ap-south-1"
  
}
variable "vpc_cidr_block" {
    type = string
    default = "10.0.0.0/16"
  
}
variable "subnet_cidr_block" {
    type = string
    default = "10.0.1.0/24"
  
}
