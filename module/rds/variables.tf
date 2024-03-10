variable "aws_region" {
  description = "Region in which AWS resources to be created"
  type        = string
  default     = "ap-southeast-1"
}

variable "db_identifier"{
    description ="Aws in db identifier"
    type = string
    default ="my-wordpress-db"
    }
    variable "db_allocated_storage"{
        type= string
        default= "20"
    }
    variable "db_storage_type"{
        type= string
        default="gp2"
    }
    variable "db_engine"{
        type=string
        default="mysql"
    }
    variable "db_engine_version"{
        type=string
        default= "5.7"
    }
    variable "db_instance_class"{
      type=string
      default= "db.t2.micro"
    }
      variable "db_username"{
        type=string
        default="admin"
      }
      variable "db_password"{
        type=string
        default="admin1234"
      }
      variable "db_tag"{
        type= string
        default="wordpress"
      }
