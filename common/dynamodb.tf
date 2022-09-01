resource "aws_dynamodb_table" "hj" {
  name = "${var.session.table_name}"
  hash_key = "${var.session.key_name}"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "${var.session.key_name}"
    type = "S"
  }
}
