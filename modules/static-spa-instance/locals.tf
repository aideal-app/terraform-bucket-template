locals {
  full_dns_address     = var.dns_record_name == null ? data.cloudflare_zone.default.name : "${var.dns_record_name}.${data.cloudflare_zone.default.name}"
  s3_spa_origin_id     = "S3-static-spa"
  s3_uploads_origin_id = "S3-uploads"

  tags = merge({
    Application = var.app_name
    Instance    = var.instance_name
    Environment = var.environment
  }, var.tags)
}