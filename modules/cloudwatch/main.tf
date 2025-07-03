variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU usage threshold for alarm"
  type        = number
  default     = 70
}

variable "log_retention_days" {
  description = "Days to retain logs in CloudWatch Log Group"
  type        = number
  default     = 7
}

resource "aws_cloudwatch_log_group" "web_logs" {
  name              = "log-group"
  retention_in_days = var.log_retention_days
}

resource "aws_sns_topic" "alert_topic" {
  name = "high_cpu_alerts"
}

resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  endpoint  = "jkkinin360@gmail.com"  # Replace with your email address
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_asg_alarm" {
  alarm_name          = "HighCPU-ASG"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Triggers when average CPU > threshold for ASG"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [aws_sns_topic.alert_topic.arn]
}