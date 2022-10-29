variable "region" {}
variable "az1" {}
variable "az2" {}
variable "bastion" {
  type = map(any)

  default = {
    image_id = ""
    key_name = ""
  }
}

variable "template" {
  type = map(any)

  default = {
    image_id = ""
    key_name = ""
  }
}

variable "database" {
  type = map(any)

  default = {
    host              = ""
    port              = ""
    db_name           = ""
    username          = ""
    password          = ""
    engine            = ""
    engine_version    = ""
    instance_class    = ""
    num_of_instances  = ""
  }
}

variable "session" {
  type = map(any)

  default = {
    table_name = ""
    key_name = ""
  }
}

variable "s3_original" {
  type = map(any)

  default = {
    bucket_name = ""
  }
}

variable "s3_thumbnail" {
  type = map(any)

  default = {
    bucket_name = ""
  }
}

variable "app" {
  type = map(any)

  default = {
    image_id      = ""
    instance_type = ""
    key_name      = ""
    max_size      = 2
    min_size      = 1
  }
}
