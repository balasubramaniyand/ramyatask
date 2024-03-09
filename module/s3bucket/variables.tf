variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "ap-south-1"
}

variable "aws_s3_bucket"{
    description ="Aws in db identifier"
    type = string
    default ="wordpress0703"
    }
    