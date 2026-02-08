resource "aws_lambda_function" "report_lambda" {
  function_name = "${var.project_name}-report-lambda"
  filename      = "../lambdas/report_lambda/report_lambda.zip"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.10"
  role          = aws_iam_role.lambda_role.arn
  timeout       = 60
}
