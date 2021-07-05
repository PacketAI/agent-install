resource "aws_lambda_function" "lambda" {
  function_name = "ecs_cloudwatch_${var.cluster_name}"
  role          = aws_iam_role.role.arn
  package_type  = "Image"
  image_uri     = "public.ecr.aws/packetai/ecslambda:v2"

  environment {
    variables = {
      INFRA_ID   = var.INFRA_ID
      INGEST_URL = var.INGEST_URL
    }
  }
}
