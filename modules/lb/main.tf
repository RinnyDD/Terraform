# Application Load Balancer (ALB)
resource "aws_lb" "app_lb" {
  name               = "web-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  tags = {
    Name = "Web-App-LB"
  }
}

# ALB Listener on Port 80 (HTTP)
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
