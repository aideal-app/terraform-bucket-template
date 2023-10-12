# ------------------------------------------------------------------------------
# MULTER
# ------------------------------------------------------------------------------

resource "aws_iam_user" "multer" {
  name = "multer-s3-${local.app_name_full}"
  path = "/app/${var.app_name}/"
}

data "aws_iam_policy_document" "multer_s3" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.uploads.arn}/*"]
  }
}

resource "aws_iam_user_policy" "multer_s3" {
  name   = "policy-multer-s3-${local.app_name_full}"
  user   = aws_iam_user.multer.name
  policy = data.aws_iam_policy_document.multer_s3.json
}

# ------------------------------------------------------------------------------
# GITHUB ACTIONS
# ------------------------------------------------------------------------------

resource "aws_iam_user" "github" {
  name = "github-action-${local.app_name_full}"
  path = "/app/${var.app_name}/"
}

data "aws_iam_policy_document" "github" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:ListBucket", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.spa.arn}/*"]
  }
}

resource "aws_iam_user_policy" "github" {
  name   = "policy-github-actions-${local.app_name_full}"
  user   = aws_iam_user.github.name
  policy = data.aws_iam_policy_document.github.json
}

resource "aws_iam_access_key" "github" {
  user = aws_iam_user.github.name
}

resource "aws_ssm_parameter" "github" {
  name  = "/iam/${aws_iam_user.github.name}/accesskey"
  type  = "SecureString"
  tier  = "Standard"
  value = "${aws_iam_access_key.github.id}:${aws_iam_access_key.github.secret}"
}