variable "region" {
  default = "ap-southeast-2"
}

variable "db_username" {
  default = "TeamNH"
}

variable "db_password" {
  
}

variable "db_name" {
  default = "course"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  default = 20
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "subnet_ids" {            # <-- Added this variable
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}
