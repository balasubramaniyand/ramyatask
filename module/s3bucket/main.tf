provider "aws" {
  region = var.aws_region
}
resource "aws_s3_bucket" "wordpress_bucket" {
  bucket = var.aws_s3_bucket
  acl    = "private"
}