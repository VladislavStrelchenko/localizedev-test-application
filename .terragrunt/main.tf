module "container_registry" {
  source        = "./modules/container_registry"
  do_token      = var.do_token
  do_region     = var.do_region
  registry_name = "localizedev-registry"
}

module "app" {
  source                          = "./modules/app"
  do_token                        = var.do_token
  do_region                       = var.do_region
  project_name                    = var.project_environment
  docker_image_name               = var.docker_image_name
  docker_image_tag                = var.docker_image_tag
  app_listen_port                 = var.app_listen_port
  app_deploy_on_docker_image_push = var.app_deploy_on_docker_image_push
  registry_dependency             = module.container_registry.registry_id
}
