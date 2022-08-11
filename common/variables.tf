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
    name = ""
    username = ""
    password = ""
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
