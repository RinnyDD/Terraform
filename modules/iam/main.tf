resource "aws_iam_role" "group_168_iam_role_name" {
  name = "group_168_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "group_168_policy_name" {
  name        = "group_168_policy"
  description = "An example policy"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}


# 1. Fix the role/policy references (you had typos)
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.group_168_iam_role_name.name  # Fixed reference
  policy_arn = aws_iam_policy.group_168_policy_name.arn   # Fixed reference
}

# 2. Add the REQUIRED instance profile
resource "aws_iam_instance_profile" "group_168_profile" {
  name = "group_168_instance_profile"
  role = aws_iam_role.group_168_iam_role_name.name  # Links profile to role
}
