provider "aws" {
  region = var.region
}

resource "aws_lb" "wordpress_alb" {
  count = var.alb_enabled ? 1 : 0

  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security_groups.alb_sg_id]
  subnets            = var.alb_subnets

  enable_deletion_protection = false # Adjust as needed

  enable_http2       = true
  enable_cross_zone_load_balancing = true

  enable_deletion_protection = false # Adjust as needed
}

resource "aws_route53_record" "wordpress_dns" {
  count = var.alb_enabled ? 0 : 1

  name    = var.dns_name
  type    = "A"
  zone_id = aws_route53_zone.main.zone_id

  ttl = 300

  records = [module.ec2.instance_private_ip]
}
