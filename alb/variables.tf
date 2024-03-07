variable "region" {
  description = "AWS region for resources"
  type        = string
  default = "ap-south-1"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "alb_enabled" {
  description = "Set to true to create ALB, false for DNS"
  type        = bool
}

variable "alb_subnets" {
  description = "Subnets for ALB"
  type        = list(string)
}

variable "dns_name" {
  description = "DNS name for WordPress"
  type        = string
  default = ""
}