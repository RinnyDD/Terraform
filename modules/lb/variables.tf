variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to associate with the Load Balancer"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the target group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for ASG or other resources"
}

