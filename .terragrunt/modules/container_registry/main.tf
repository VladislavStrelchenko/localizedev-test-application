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

#---------------- RESOURCES ----------------#

resource "digitalocean_container_registry" "registry" {
  name                   = var.registry_name
  subscription_tier_slug = "starter"
  region                 = var.do_region
}
