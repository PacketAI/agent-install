data "aws_cloudwatch_log_group" "container_insight" {
  name = "/aws/ecs/containerinsights/${var.cluster_name}/performance"
}

resource "aws_lambda_permission" "container_insight" {
  statement_id  = "AllowExecutionFromCloudWatchContainerInsight_${var.cluster_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "logs.amazonaws.com"
  source_arn    = data.aws_cloudwatch_log_group.container_insight.arn
}

resource "aws_cloudwatch_log_subscription_filter" "container_insight" {
  depends_on      = [aws_lambda_permission.container_insight]
  name            = "container_insight_subscription_${var.cluster_name}"
  log_group_name  = data.aws_cloudwatch_log_group.container_insight.name
  filter_pattern  = ""
  destination_arn = aws_lambda_function.lambda.arn
}
