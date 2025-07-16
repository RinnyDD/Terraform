output "target_group_arn" {
  value = aws_lb_target_group.web_tg.arn
}

output "aws_autoscaling_group" {
  value = aws_autoscaling_group.my-web-asg.name
}