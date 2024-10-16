resource "aws_iam_role" "lambda" {
  name        = "${local.module_name}-${var.env}-lambda-${random_id.id.hex}"
  description = "IAM role for the cloudwatch to google chat terraform module"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda" {
  name        = "${local.module_name}-${var.env}-lambda-policy-${random_id.id.hex}"
  description = "Cloudwatch log group for the cloudwatch to google chat terraform module"

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Action" = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Effect"   = "Allow",
        "Resource" = "${aws_cloudwatch_log_group.lambda.arn}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}
