resource "aws_cloudfront_origin_access_control" "default" {
  name                              = local.full_dns_address
  description                       = "S3 access to ${var.instance_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "default" {
  comment             = "CDN for static SPA instance"
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = [local.full_dns_address]
  wait_for_deployment = false

  price_class = "PriceClass_100"

  origin {
    domain_name              = data.aws_s3_bucket.spa.bucket_regional_domain_name
    origin_id                = local.s3_spa_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_path              = "/${var.instance_name}"
  }

  origin {
    domain_name              = data.aws_s3_bucket.uploads.bucket_regional_domain_name
    origin_id                = local.s3_uploads_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_path              = "/${var.instance_name}"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_spa_origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    path_pattern           = "/uploads/*"
    target_origin_id       = local.s3_uploads_origin_id
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    error_caching_min_ttl = 0
    response_page_path    = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.default.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  tags = {
    Name = local.full_dns_address
  }
}