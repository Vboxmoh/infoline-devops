provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_login_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_lambda_function" "login_function" {
  function_name = "login-function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "Login::handleRequest"
  runtime       = "java17"

  filename      = "login.jar"
}
