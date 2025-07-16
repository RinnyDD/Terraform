provider "aws" {
  region = var.region
}

resource "aws_db_subnet_group" "course_db_subnet_group" {
  name       = "course-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "course-db-subnet-group"
  }
}

resource "aws_db_instance" "course_db" {
  identifier              = "course-database"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  db_name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = var.vpc_security_group_ids
  db_subnet_group_name    = aws_db_subnet_group.course_db_subnet_group.name
  storage_encrypted       = true
  backup_retention_period = 7
  deletion_protection     = false

  tags = {
    Name = "course-db"
  }
}
