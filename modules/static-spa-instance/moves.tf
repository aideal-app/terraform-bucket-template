moved {
  from = aws_s3_object.instance_dir
  to   = aws_s3_object.spa_instance_dir
}

moved {
  from = aws_s3_bucket_policy.cloudfront
  to   = aws_s3_bucket_policy.spa_cloudfront
}