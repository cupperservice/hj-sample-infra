data "archive_file" "thumbnail" {
  type        = "zip"
  source_file = "../lambda/src/thumbnail.js"
  output_path = "../lambda/thumbnail.zip"
}

data "archive_file" "layer" {
  type        = "zip"
  source_dir  = "../lambda/src"
  output_path = "../lambda/sharp.zip"
  excludes    = ["../lambda/thumbnail.js"]
}

resource "aws_lambda_function" "thumbnail" {
  filename  = "${var.lambda.function_file}"
  function_name = "thumbnail"
  role          = "${var.lambda.role}"
  handler       = "thumbnail.handler"
  layers        = [aws_lambda_layer_version.sharp.arn]
  runtime       = "nodejs16.x"
  timeout       = 30
}

resource "aws_lambda_layer_version" "sharp" {
  filename    = "${var.lambda.layer_file}"
  layer_name  = "sharp"
  compatible_runtimes = ["nodejs16.x"]
}
