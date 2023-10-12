data "aws_s3_bucket" "spa" {
  bucket = var.spa_bucket_name
}

data "aws_s3_bucket" "uploads" {
  bucket = var.uploads_bucket_name
}

data "aws_iam_policy_document" "spa_s3_bucket_policy" {
  source_policy_documents = [var.spa_bucket_policy_json]

  statement {
    sid       = "cloudfront_${var.instance_name}"
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.spa.arn}/${var.instance_name}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.default.arn]
    }
  }
}

data "aws_iam_policy_document" "uploads_s3_bucket_policy" {
  source_policy_documents = [var.uploads_bucket_policy_json]

  statement {
    sid       = "cloudfront_${var.instance_name}"
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.uploads.arn}/${var.instance_name}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.default.arn]
    }
  }
}

resource "aws_s3_object" "spa_instance_dir" {
  bucket       = data.aws_s3_bucket.spa.id
  key          = "${var.instance_name}/"
  content_type = "application/x-directory"
  acl          = "private"
}

resource "aws_s3_object" "uploads_instance_dir" {
  bucket       = data.aws_s3_bucket.uploads.id
  key          = "${var.instance_name}/"
  content_type = "application/x-directory"
  acl          = "private"
}

resource "aws_s3_bucket_policy" "spa_cloudfront" {
  bucket = data.aws_s3_bucket.spa.id
  policy = data.aws_iam_policy_document.spa_s3_bucket_policy.json
}

resource "aws_s3_bucket_policy" "uploads_cloudfront" {
  bucket = data.aws_s3_bucket.uploads.id
  policy = data.aws_iam_policy_document.uploads_s3_bucket_policy.json
}