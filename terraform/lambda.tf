resource "aws_lambda_function" "ingest_lambda" {
  function_name = "${var.project_name}-ingest-lambda"
  filename      = "../lambdas/ingest_lambda/ingest_lambda.zip"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.10"
  role   = aws_iam_role.lambda_role.arn
  environment {
    variables = {
      RAW_BUCKET = aws_s3_bucket.raw_bucket.bucket
    }
  }
  timeout = 10
}

resource "aws_lambda_function" "process_lambda" {
  function_name = "${var.project_name}-process-lambda"
  filename      = "../lambdas/process_lambda/process_lambda.zip"

  handler = "lambda_function.lambda_handler"
  runtime = "python3.10"
  role   = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      PROCESSED_BUCKET = aws_s3_bucket.processed_bucket.bucket
    }
  }

  timeout = 10
}
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.raw_bucket.arn
}
