module "aideal-spa" {
  source = "../../modules/static-spa"

  app_name    = "aideal"
  environment = local.environment
  tags        = local.tags
}

module "aideal-spa-demo" {
  source = "../../modules/static-spa-instance"

  app_name                   = "aideal"
  instance_name              = "demo"
  dns_zone_id                = cloudflare_zone.aideal.id
  dns_record_name            = "demo"
  spa_bucket_name            = module.aideal-spa.spa_bucket_name
  spa_bucket_policy_json     = module.aideal-spa.spa_bucket_policy_json
  uploads_bucket_name        = module.aideal-spa.uploads_bucket_name
  uploads_bucket_policy_json = module.aideal-spa.uploads_bucket_policy_json
  environment                = local.environment
  tags                       = local.tags
}