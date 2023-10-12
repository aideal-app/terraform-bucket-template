variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "instance_name" {
  type        = string
  description = "Instance Name"
}


variable "dns_zone_id" {
  type        = string
  description = "DNS zone ID from Cloudflare"
}

variable "dns_record_name" {
  type        = string
  description = "The name of the DNS record"
}

variable "spa_bucket_name" {
  type        = string
  description = "The bucket where SPA is stored"
}

variable "spa_bucket_policy_json" {
  type        = string
  description = "The policty JSON of SPA bucket"
}

variable "uploads_bucket_name" {
  type        = string
  description = "The bucket where uploaded files are stored"
}

variable "uploads_bucket_policy_json" {
  type        = string
  description = "The policty JSON of uploads bucket"
}

variable "environment" {
  type    = string
  default = "Production"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags that will be added to created resources."
  default     = {}
}