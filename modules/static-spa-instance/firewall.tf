resource "cloudflare_ruleset" "default" {
  zone_id = data.cloudflare_zone.default.zone_id
  kind    = "zone"
  name    = "Block robots"
  phase   = "http_request_firewall_custom"

  rules {
    description = "Enforce challenge for unknown browsers or non-Brazilian origins"
    expression  = "(not http.user_agent contains \"Mozilla\") or (ip.geoip.country ne \"BR\")"
    action      = "managed_challenge"
  }
}