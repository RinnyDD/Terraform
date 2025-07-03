output "log_group_name" {
  value = aws_cloudwatch_log_group.web_logs.name
}

output "cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu_asg_alarm.alarm_name
}
