# target group
resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  stickiness {
    type            = "lb_cookie"      # Uses LB-generated cookie
    enabled         = true
    cookie_duration = 86400            # 1 day (in seconds)
  }

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 5
    
  }
}

# template
resource "aws_launch_template" "web_template" {
  name_prefix   = "my-web"
  image_id      = "ami-010876b9ddd38475e"   
  instance_type = "t2.micro"
  key_name      = "Bopha"

  # IAM role
  iam_instance_profile {
    name = var.instance_profile_name  # Reference to the IAM instance profile
  }
  
    user_data = base64encode(<<EOF


EOF
)



  

  # Security groups
  vpc_security_group_ids = var.security_group_ids  # Reference to the security group IDs

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "MyWebInstance"
    }
  }
}


# auto scaling group
resource "aws_autoscaling_group" "my-web-asg" {
  name = "my-web-asg"
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  target_group_arns = [ aws_lb_target_group.web_tg.arn ]

  health_check_type          = "ELB"
  health_check_grace_period  = 300

  depends_on = [aws_lb_target_group.web_tg]
}
