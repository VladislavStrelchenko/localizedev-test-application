output "project_id" {
  value = digitalocean_project.project.id
}

output "project_name" {
  value = digitalocean_project.project.name
}

output "app_id" {
  value = length(digitalocean_app.app) > 0 ? digitalocean_app.app[0].id : null
}

output "app_live_url" {
  value = length(digitalocean_app.app) > 0 ? digitalocean_app.app[0].live_url : null
}
