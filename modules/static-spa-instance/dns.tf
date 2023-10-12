data "cloudflare_zone" "default" {
  zone_id = var.dns_zone_id
}

resource "cloudflare_record" "app" {
  zone_id = data.cloudflare_zone.default.id
  name    = var.dns_record_name == null ? "@" : var.dns_record_name
  type    = "CNAME"
  value   = aws_cloudfront_distribution.default.domain_name
  proxied = true
}