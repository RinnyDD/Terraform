variable "region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "course_bucket" {
  bucket = var.bucket_name
}

# resource "aws_s3_bucket_acl" "course_bucket_acl" {
#   bucket = aws_s3_bucket.course_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket_versioning" "course_bucket_versioning" {
  bucket = aws_s3_bucket.course_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "course_bucket_sse" {
  bucket = aws_s3_bucket.course_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket                  = aws_s3_bucket.course_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.course_bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowAccessFromIAMRole",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::000576340633:role/group_168_iam_role"
        },
        "Action": [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        "Resource": [
          "arn:aws:s3:::teamnh-course-bucket-168",
          "arn:aws:s3:::teamnh-course-bucket-168/*"
        ]
      },
      {
        "Sid": "AllowPublicReadForGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::teamnh-course-bucket-168/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.block_public_access]
}
