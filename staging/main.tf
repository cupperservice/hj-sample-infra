terraform {
  required_version = "= 1.2.9"  // terraform --version で表示されたバージョンに変える
}

module "common" {
  source = "../common"
  region = "XXXXX"  // リージョン
  az1 = "XXXXX"     // アベイラビリティゾーン(az1と違う値)
  az2 = "XXXXX"     // アベイラビリティゾーン(az2と違う値)
  bastion = {
    image_id = "XXXXX"  // Amazon Linux 2 のAMI ID
    key_name = "XXXXX"  // キーペア
  }
  template = {
    image_id = "XXXXX"  // Amazon Linux 2 のAMI ID
    key_name = "XXXXX"  // キーペア
  }
  database = {
    host              = "localhost"   // RDS 作成完了後に Writer instance のEndpoint を設定する
    port              = "3306"
    db_name           = "mydb"
    username          = "XXXXX" // RDS のマスターユーザー名（値は自分で決める）
    password          = "XXXXX" // RDS のマスターパスワード（値は自分で決める。英数字8文字以上にすること）
    engine            = "aurora-mysql"
    engine_version    = "5.7.mysql_aurora.2.11.0"
    instance_class    = "db.t3.small"
    num_of_instances  = "0"
  }
  session = {
    table_name = "session-table"
    key_name = "sessionId"
  }
  s3_original = {
    bucket_name = "XXXXX"   // S3バケット名（値は自分で決める。ブラウザからアップロードした画像の保管先）
  }
  s3_thumbnail = {
    bucket_name = "XXXXX"   // S3バケット名（値は自分で決める。アップロードした画像から作成したサムネイル画像の保管先）
  }
  app = {
    image_id = "XXXXX"      // Amazon Linux 2 のAMI ID
    instance_type = "t2.small"
    key_name = "XXXXX"      // キーペア
    max_size = 0
    min_size = 0
  }
  lambda = {
    function_file = "../lambda/thumbnail.zip"
    layer_file    = "../lambda/sharp.zip"
    role          = "XXXXX" // LabRole のARN (https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-1#/roles)
  }
}
