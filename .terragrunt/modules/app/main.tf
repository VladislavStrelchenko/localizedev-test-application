terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.0.0"
    }
  }

  backend "s3" {}
}

provider "digitalocean" {
  token = var.do_token
}

#------------------ ENVS ------------------#

locals {
  image_defined = (
  (var.docker_image_name != null && var.docker_image_name != "") &&
  (var.docker_image_tag != null && var.docker_image_tag != "")
  ) ? 1 : 0
}

#---------------- RESOURCES ----------------#

resource "digitalocean_project" "project" {
  name        = var.project_name
  purpose     = "Web Application"
  environment = var.project_environment
}

resource "digitalocean_app" "app" {
  count      = local.image_defined
  project_id = digitalocean_project.project.id

  spec {
    name    = format("%s-%s", var.docker_image_name, "app")
    region  = var.do_region

    service {
      http_port          = var.app_listen_port
      instance_count     = 1
      instance_size_slug = var.app_instance_size_slug
      name               = var.docker_image_name

      image {
        registry_type = "DOCR"
        repository    = var.docker_image_name
        tag           = var.docker_image_tag

        deploy_on_push {
          enabled = var.app_deploy_on_docker_image_push
        }
      }

      env {
        key   = "LISTEN_PORT"
        value = var.app_listen_port
      }
    }

    alert {
      rule = "DEPLOYMENT_FAILED"
    }
  }

  depends_on = [digitalocean_project.project, var.registry_dependency]
}
