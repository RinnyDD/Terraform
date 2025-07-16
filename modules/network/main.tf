# Public ALB (Load Balancer) Security Group
resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Allow HTTP/HTTPS to ALB"
  vpc_id      =  var.vpc_id 

  # INGRESS (Public HTTP/HTTPS)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: Open to internet!
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: Open to internet!
  }

  # EGRESS (Allow all outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private EC2 Instances (ASG) Security Group
resource "aws_security_group" "asg" {
  name        = "asg-sg"
  description = "Allow traffic only from ALB + SSH from trusted IPs"
  vpc_id      = var.vpc_id  

  # INGRESS (Allow traffic ONLY from ALB)
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]  # Critical: Lock to ALB only
  }

  # Optional: SSH from trusted IPs (e.g., your office)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # REPLACE WITH YOUR IP!
  }

  # EGRESS (Allow all outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Database (RDS/Aurora) Security Group
resource "aws_security_group" "db" {
  name        = "db-sg"
  description = "Allow traffic only from ASG instances"
  vpc_id      = var.vpc_id  # Same VPC as other resources

  # INGRESS: Only allow traffic from ASG instances
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: Open to all traffic!
  }

  # EGRESS: Allow DB to initiate outbound (e.g., for backups/updates)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # WARNING: Tighten this for production!
  }

  tags = {
    Name = "db-sg"
  }
}
