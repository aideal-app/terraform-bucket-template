locals {
  is_development = var.environment == "Development"
  env_suffix     = local.is_development ? "dev" : "prd"
  app_name_full  = "${var.app_name}-${local.env_suffix}"

  tags = merge({
    Application = var.app_name
    Environment = var.environment
  }, var.tags)
}