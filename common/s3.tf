# s3 original
resource "aws_s3_bucket" "original" {
  bucket = "${var.s3_original.bucket_name}"
  tags = {
    Name = "${var.s3_original.bucket_name}"
  }
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "original" {
  bucket = aws_s3_bucket.thumbnail.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "original" {
  bucket = aws_s3_bucket.original.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    sid = "web1"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "${aws_s3_bucket.original.arn}"
    ]
  }

  statement {
    sid = "web2"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.original.arn}/*"
    ]
  }
}
# s3 thumbnail
resource "aws_s3_bucket" "thumbnail" {
  bucket = "${var.s3_thumbnail.bucket_name}"
  tags = {
    Name = "${var.s3_thumbnail.bucket_name}"
  }
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "thumbnail" {
  bucket = aws_s3_bucket.thumbnail.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "thumbnail" {
  bucket = aws_s3_bucket.thumbnail.id
  policy = data.aws_iam_policy_document.thumbnail.json
}

data "aws_iam_policy_document" "thumbnail" {
  statement {
    sid = "web1"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "${aws_s3_bucket.thumbnail.arn}"
    ]
  }

  statement {
    sid = "web2"
    effect = "Allow"
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.thumbnail.arn}/*"
    ]
  }
}
