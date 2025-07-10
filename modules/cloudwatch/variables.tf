variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU usage threshold for ASG alarm"
  type        = number
  default     = 70
}

variable "rds_instance_id" {
  description = "ID of the RDS instance to monitor"
  type        = string
}

variable "rds_cpu_threshold" {
  description = "CPU usage threshold for RDS alarm"
  type        = number
  default     = 80
}

variable "log_retention_days" {
  description = "Days to retain logs in CloudWatch Log Group"
  type        = number
  default     = 7
}
