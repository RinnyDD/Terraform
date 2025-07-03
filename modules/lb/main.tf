# Security Group for Load Balancer
# resource "aws_security_group" "lb_sg" {
#   name        = "lb-sg"
#   description = "Allow HTTP traffic"
#   vpc_id      = "vpc-0b27c0817fd3bb966"

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "LoadBalancer-SG"
#   }
# }

# Target Group for EC2 Instances
# resource "aws_lb_target_group" "web_target_group" {
#   # name     = "web-
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = "vpc-0b27c0817fd3bb966"

#   health_check {
#     path                = "/"
#     protocol            = "HTTP"
#     matcher             = "200"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }
# }

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
