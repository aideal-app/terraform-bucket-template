variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}

variable "CLOUDFLARE_API_TOKEN" {
  type        = string
  description = "Cloudflare API token"
  sensitive   = true
}