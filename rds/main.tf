provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "wordpress" {
  identifier                = var.db_identifier
  allocated_storage         = var.db_allocated_storage
  storage_type              = var.db_storage_type
  engine                    = var.db_engine
  engine_version            = var.db_engine_version
  instance_class            = var.db_instance_class
  username                  = var.db_username
  password                  = var.db_password

  

  tags = {
    Name = "db_tag"
  }
  skip_final_snapshot = true
}
