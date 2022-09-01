resource "aws_cloudwatch_log_group" "hj-sample-app_access" {
  name = "hj-sample-app/access.log"

  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "hj-sample-app_application" {
  name = "hj-sample-app/application.log"

  retention_in_days = 1
}
