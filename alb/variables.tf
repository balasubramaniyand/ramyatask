variable "aws_region" {
  type=string
  default = "ap-south-1"
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public1_cidr_block" {
  description = "The CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public2_cidr_block" {
  description = "The CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/health"
}

variable "health_check_port" {
  description = "The port for the health check"
  type        = string
  default     = "80"
}
