resource "aws_lambda_function" "lambda" {
  function_name = "packetai_ecs_cloudwatch_${var.cluster_name}"
  role          = aws_iam_role.role.arn
  package_type  = "Zip"
  filename      = "ecs_python_lambda.zip"
  source_code_hash = filebase64sha256("ecs_python_lambda.zip")
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      INFRA_ID   = var.INFRA_ID
      INGEST_URL = var.INGEST_URL
    }
  }
}
