resource "aws_iam_role" "group_168_iam_role_name" {
  name = "group_168_iam_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "group_168_policy_name" {
  name        = "group_168_policy"
  description = "Allow EC2 to read from specific S3 bucket"
  policy = jsonencode({
  Version = "2012-10-17",
  Statement = [
    {
  Effect = "Allow",
  Action = [
    "s3:ListBucket",
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject"
  ],
  Resource = [
  "arn:aws:s3:::teamnh-course-bucket-168",
  "arn:aws:s3:::teamnh-course-bucket-168/*"
  ]
}

  ]
})
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.group_168_iam_role_name.name
  policy_arn = aws_iam_policy.group_168_policy_name.arn
}

resource "aws_iam_instance_profile" "group_168_profile" {
  name = "group_168_instance_profile"
  role = aws_iam_role.group_168_iam_role_name.name
}
