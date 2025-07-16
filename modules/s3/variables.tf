variable "security_group_ids" {
  type    = list(string)
  default = []
  description = "Optional security group ids, not required for S3"
}
