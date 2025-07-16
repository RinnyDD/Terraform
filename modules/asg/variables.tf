variable "instance_profile_name" {
  type        = string
  description = "description"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the ASG"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for ASG or other resources"
}
variable "db_endpoint" {
  type = string
}