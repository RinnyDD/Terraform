output "bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.course_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket"
  value       = aws_s3_bucket.course_bucket.arn
}
output "bucket_id" {
  description = "The ID of the created S3 bucket"
  value       = aws_s3_bucket.course_bucket.id
}