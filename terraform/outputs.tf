output "raw_bucket_name" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "processed_bucket_name" {
  value = aws_s3_bucket.processed_bucket.bucket
}

output "report_bucket_name" {
  value = aws_s3_bucket.report_bucket.bucket
}
output "api_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

