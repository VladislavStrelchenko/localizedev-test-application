output "registry_url" {
  value = module.container_registry.registry_endpoint
}

output "app_live_url" {
  value = module.app.app_live_url
}
