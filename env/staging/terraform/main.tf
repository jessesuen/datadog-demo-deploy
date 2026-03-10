resource "aws_iam_role" "lambda_role" {
  name = "datadog-demo-${var.env_name}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Effect" : "Allow"
    }]
  })
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name = "datadog-demo-${var.env_name}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "lambda:InvokeFunction",
          "lambda:GetFunctionConfiguration",
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

resource "aws_lambda_function" "datadog-demo" {
  function_name = "datadog-demo-${var.env_name}"
  description   = "lambda function from terraform"
  image_uri     = var.image_uri
  package_type  = "Image"
  architectures = ["x86_64"]
  role          = aws_iam_role.lambda_role.arn
}

resource "aws_lambda_function_url" "datadog-demo" {
  function_name      = aws_lambda_function.datadog-demo.function_name
  authorization_type = "NONE"

  lifecycle {
    # recreate function URL when lambda function is updated
    replace_triggered_by = [aws_lambda_function.datadog-demo]
  }
}

variable "image_uri" {
 description = "Lambda container image repository URI"
 type        = string
}

variable "env_name" {
 description = "Environment name to be incorporated into resource names"
 type        = string
}