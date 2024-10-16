resource "aws_lambda_function" "sns_event_handler" {
  function_name = "${local.module_name}-${var.env}-sns-event-handler-${random_id.id.hex}"
  description   = "Processing SNS topics for the cloudwatch to google chat terraform module"

  role = aws_iam_role.lambda.arn

  handler          = "kaercher.CloudwatchToGoogleChat::kaercher.CloudwatchToGoogleChat.Function::FunctionHandler"
  filename         = "${path.module}/sns_event_handler.zip"
  source_code_hash = filebase64sha256("${path.module}/sns_event_handler.zip")

  runtime       = "dotnet8"
  architectures = ["arm64"]
  timeout       = 30

  environment {
    variables = {
      GOOGLE_CHAT_URL = var.google_chat_url
      TIMEZONE        = var.time_zone
      CULTURE_INFO    = var.culture_info
    }
  }
}

resource "aws_lambda_permission" "allow_sns" {
  for_each = var.sns_topic_arns

  statement_id_prefix = "AllowExecutionFromSNS-"
  action              = "lambda:InvokeFunction"
  function_name       = aws_lambda_function.sns_event_handler.function_name
  principal           = "sns.amazonaws.com"
  source_arn          = each.value
}

resource "aws_sns_topic_subscription" "lambda" {
  for_each = var.sns_topic_arns

  endpoint  = aws_lambda_function.sns_event_handler.arn
  protocol  = "lambda"
  topic_arn = each.value
}
