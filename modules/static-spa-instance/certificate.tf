resource "aws_acm_certificate" "default" {
  domain_name       = local.full_dns_address
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "cert" {
  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type
    }
  }

  zone_id         = data.cloudflare_zone.default.id
  name            = each.value.name
  type            = each.value.type
  value           = each.value.value
  allow_overwrite = true
  proxied         = false
  ttl             = 60
}

resource "aws_acm_certificate_validation" "default" {
  certificate_arn         = aws_acm_certificate.default.arn
  validation_record_fqdns = [for record in cloudflare_record.cert : record.hostname]
}