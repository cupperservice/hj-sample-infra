# Database parameters
resource "aws_ssm_parameter" "database_name" {
  name  = "DB_NAME"
  type  = "String"
  value = var.database.name
}

resource "aws_ssm_parameter" "database_username" {
  name  = "DB_USERNAME"
  type  = "String"
  value = var.database.username
}

resource "aws_ssm_parameter" "database_password" {
  name  = "DB_PASSWORD"
  type  = "SecureString"
  value = var.database.password
}

# Session parameters
resource "aws_ssm_parameter" "session_table_name" {
  name  = "SESSION_TABLE_NAME"
  type  = "String"
  value = var.session.table_name
}

resource "aws_ssm_parameter" "session_key_name" {
  name  = "SESSION_KEY_NAME"
  type  = "String"
  value = var.session.key_name
}

# S3
resource "aws_ssm_parameter" "s3_bucket" {
  name  = "S3_BUCKET_NAME"
  type  = "String"
  value = var.s3.bucket_name
}
