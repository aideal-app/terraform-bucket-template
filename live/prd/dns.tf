resource "cloudflare_zone" "aideal" {
  account_id = local.cloudflare_account_id
  zone       = "aideal.app.br"
  plan       = "free"
  type       = "full"
}