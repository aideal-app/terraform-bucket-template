variable "app_name" {
  type        = string
  description = "Application Name"
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