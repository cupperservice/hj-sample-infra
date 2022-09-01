terraform {
  required_version = "= 1.2.7"
}

module "common" {
  source = "../common"
  region = "us-east-1"
  az1 = "us-east-1a"
  az2 = "us-east-1c"
  bastion = {
    image_id = "ami-090fa75af13c156b4"
    key_name = "vockey"
  }
  template = {
    image_id = "ami-090fa75af13c156b4"
    key_name = "vockey"
  }
  database = {
    host            = ""
    port            = "3306"
    db_name         = "mydb"
    username        = "hamajoadmin"
    password        = "hamajoadmin00"
    engine          = "mysql"
    engine_version  = "5.7.37"
    instance_class  = "db.t3.small"
  }
  session = {
    table_name = "session-table"
    key_name = "sessionId"
  }
  s3_original = {
    bucket_name = "hj-202208-image-original"
  }
  s3_thumbnail = {
    bucket_name = "hj-202208-image-thumbnail"
  }
  app = {
    image_id = "ami-090fa75af13c156b4"
    instance_type = "t2.small"
    key_name = "vockey"
    max_size = 0
    min_size = 0
  }
}
