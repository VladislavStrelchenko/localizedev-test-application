variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "do_region" {
  description = "DigitalOcean region"
  type        = string
  default     = "fra1"
}

variable "registry_name" {
  description = "Name of the container registry"
  type        = string
  default     = "localizedev-registry"
}
