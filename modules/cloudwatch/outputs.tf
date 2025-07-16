output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.web_logs.name
  description = "Name of the CloudWatch log group"
}

output "asg_cpu_alarm_name" {
  value       = aws_cloudwatch_metric_alarm.high_cpu_asg_alarm.alarm_name
  description = "Name of the ASG high CPU alarm"
}

output "rds_cpu_alarm_name" {
  value       = aws_cloudwatch_metric_alarm.high_cpu_rds_alarm.alarm_name
  description = "Name of the RDS high CPU alarm"
}

output "sns_topic_arn" {
  value       = aws_sns_topic.alert_topic.arn
  description = "ARN of the SNS alert topic"
}
