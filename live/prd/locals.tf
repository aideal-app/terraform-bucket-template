locals {
  aws_region            = "us-east-1"
  environment           = "Production"
  cloudflare_account_id = "9adffe27f86fa51fc161d2ac9e51e656"

  tags = {
    Environment = local.environment
    Tool        = "Terraform"
  }
}