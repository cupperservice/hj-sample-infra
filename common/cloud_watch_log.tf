resource "aws_cloudwatch_log_group" "hj-sample-app/access" {
  name = "hj-sample-app/access.log"

  retention_in_days = 1
}

resource "aws_cloudwatch_log_group" "hj-sample-app/application" {
  name = "hj-sample-app/application.log"

  retention_in_days = 1
}
