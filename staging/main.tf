terraform {
  required_version = "= 1.2.6"
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
    name = "mydb"
    username = "hamajoadmin"
    password = "hamajoadmin00"
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
}
