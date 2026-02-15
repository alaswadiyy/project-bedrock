output "bucket_name" {
  description = "S3 assets bucket name"
  value       = aws_s3_bucket.assets.bucket
}

output "bucket_arn" {
  description = "S3 assets bucket ARN"
  value       = aws_s3_bucket.assets.arn
}

output "lambda_function_arn" {
  description = "Asset processor Lambda function ARN"
  value       = aws_lambda_function.processor.arn
}

output "lambda_function_name" {
  description = "Asset processor Lambda function name"
  value       = aws_lambda_function.processor.function_name
}
