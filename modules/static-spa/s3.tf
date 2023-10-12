# ------------------------------------------------------------------------------
# SPA
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "spa" {
  bucket              = "${var.app_name}-static-spa-${local.env_suffix}"
  object_lock_enabled = false

  tags = {
    Name = "${var.app_name}-static-spa-${local.env_suffix}"
  }
}

data "aws_iam_policy_document" "s3_github" {
  statement {
    sid       = "iam_github"
    actions   = data.aws_iam_policy_document.github.statement[0].actions
    resources = [aws_s3_bucket.spa.arn, "${aws_s3_bucket.spa.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.github.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "spa_github" {
  bucket = aws_s3_bucket.spa.id
  policy = data.aws_iam_policy_document.s3_github.json
}

output "spa_bucket_name" {
  value = aws_s3_bucket.spa.id
}

output "spa_bucket_policy_json" {
  value = data.aws_iam_policy_document.s3_github.json
}

# ------------------------------------------------------------------------------
# UPLOADS
# ------------------------------------------------------------------------------

resource "aws_s3_bucket" "uploads" {
  bucket              = "${var.app_name}-uploads-${local.env_suffix}"
  object_lock_enabled = false

  tags = {
    Name = "${var.app_name}-uploads-${local.env_suffix}"
  }
}

output "uploads_bucket_name" {
  value = aws_s3_bucket.uploads.id
}

output "uploads_bucket_policy_json" {
  value = ""
}