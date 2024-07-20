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

variable "project_name" {
  description = "The name of the DigitalOcean project"
  type        = string
  default     = "localizedev-test"
}

variable "project_environment" {
  description = "The environment of the DigitalOcean project"
  type        = string
  default     = "Development"
}

variable "docker_image_name" {
  description = "Name of the Docker image"
  type        = string
}

variable "docker_image_tag" {
  description = "Tag of the Docker image"
  type        = string
  default     = "latest"
}

variable "app_listen_port" {
  description = "Port the app listens on"
  type        = string
  default     = "3000"
}

variable "app_deploy_on_docker_image_push" {
  description = "Redeploy the app after docker image push"
  type        = bool
  default     = true
}

