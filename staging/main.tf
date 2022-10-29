terraform {
  required_version = "= 1.2.9"
}

module "common" {
  source = "../common"
  region = "XXXXX"
  az1 = "XXXXX"
  az2 = "XXXXX"
  bastion = {
    image_id = "XXXXX"
    key_name = "XXXXX"
  }
  template = {
    image_id = "XXXXX"
    key_name = "XXXXX"
  }
  database = {
    host              = "localhost"
    port              = "3306"
    db_name           = "mydb"
    username          = "XXXXX"
    password          = "XXXXX"
    engine            = "aurora-mysql"
    engine_version    = "5.7.mysql_aurora.2.11.0"
    instance_class    = "db.t3.small"
    num_of_instances  = "2"
  }
  session = {
    table_name = "session-table"
    key_name = "sessionId"
  }
  s3_original = {
    bucket_name = "XXXXX"
  }
  s3_thumbnail = {
    bucket_name = "XXXXX"
  }
  app = {
    image_id = "XXXXX"
    instance_type = "t2.small"
    key_name = "XXXXX"
    max_size = 0
    min_size = 0
  }
}
