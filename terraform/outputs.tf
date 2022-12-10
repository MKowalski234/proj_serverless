output "bucket_domain_name" {
  value       = aws_s3_bucket.my-reason-for-depression.*.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.my-reason-for-depression.*.website_endpoint
  description = "The bucket website endpoint, if website is enabled"
}

output "bucket_arn" {
  value       = aws_s3_bucket.my-reason-for-depression.*.arn
  description = "Bucket ARN"
}

