# Create CloudWatch Log Group
resource "aws_cloudwatch_log_group" "web_logs" {
  name              = "log-group"
  retention_in_days = var.log_retention_days
}

# Create SNS Topic
resource "aws_sns_topic" "alert_topic" {
  name = "high_cpu_alerts"
}

# Optional email subscription to SNS topic
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.alert_topic.arn
  protocol  = "email"
  # endpoint  = "your-email@example.com"  # Uncomment and replace with your email
}

# CloudWatch Alarm for ASG High CPU
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

# CloudWatch Alarm for RDS High CPU
resource "aws_cloudwatch_metric_alarm" "high_cpu_rds_alarm" {
  alarm_name          = "HighCPU-RDS"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = var.rds_cpu_threshold
  alarm_description   = "Triggers when RDS CPU > threshold"
  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
  alarm_actions = [aws_sns_topic.alert_topic.arn]
}
