variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "security_group_name" {
  type    = string
  default = "wordpress-sg"
}

variable "http_port" {
  type    = number
  default = 80
}

variable "https_port" {
  type    = number
  default = 443
}

variable "cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}
