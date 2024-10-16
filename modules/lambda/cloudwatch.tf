resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${aws_lambda_function.sns_event_handler.function_name}"
  retention_in_days = 90
}
