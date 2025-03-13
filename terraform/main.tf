provider "aws" {
  region = "eu-west-2"

}



resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : "ec2:StartInstances",
        "Resource" : "*"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : "logs:CreateLogGroup",
        "Resource" : "arn:aws:logs:eu-west-2:977098994448:*"
      },
      {
        "Sid" : "VisualEditor2",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:eu-west-2:977098994448:log-group:/aws/lambda/StartEC2Instances:*"
      }
    ]
  })
}



resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}


data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/start-EC2-instance.zip"
}


resource "aws_lambda_function" "test_lambda" {
  filename      = "${path.module}/python/start-EC2-instance.zip"
  function_name = "start_EC2_instances"
  role          = aws_iam_role.lambda_role.arn
  handler       = "start-EC2-instance.lambda_handler"
  runtime       = "python3.13"
  timeout       = 10
  depends_on    = [aws_iam_role_policy_attachment.lambda_policy_attachment]
}


resource "aws_cloudwatch_event_rule" "console" {
  name                = "StartEC2EventHour"
  schedule_expression = "rate(60 minutes)"


}

resource "aws_cloudwatch_event_target" "yada" {
  rule = aws_cloudwatch_event_rule.console.name
  arn  = aws_lambda_function.test_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.console.arn
}