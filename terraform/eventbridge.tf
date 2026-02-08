resource "aws_cloudwatch_event_rule" "daily_report" {
  name                = "daily-report-rule"
  schedule_expression = "cron(0 0 * * ? *)" # every day at 00:00 UTC
}

resource "aws_cloudwatch_event_target" "report_lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_report.name
  target_id = "report-lambda"
  arn       = aws_lambda_function.report_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.report_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_report.arn
}
