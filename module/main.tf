module "rds" {
    source = "/root/module/rds"
}
module "VPC" {
    source = "/root/module/VPC"
}
module "alb" {
    source = "/root/module/alb"
}
module "s3bucket" {
    source = "/root/module/s3bucket"
}
module "security" {
    source = "/root/module/security"  
}