terraform {
  source = "./"
}

inputs = {
  do_token                        = get_env("TF_VAR_DO_TOKEN", "")
  do_region                       = get_env("TF_VAR_DO_REGION", "fra1")
  project_name                    = get_env("TF_VAR_PROJECT_NAME", "test-project")
  project_environment             = get_env("TF_VAR_PROJECT_ENVIRONMENT", "Development")
  app_listen_port                 = get_env("TF_VAR_APP_LISTEN_PORT", "3000")
  docker_image_name               = get_env("TF_VAR_DOCKER_IMAGE_NAME", "")
  docker_image_tag                = get_env("TF_VAR_DOCKER_IMAGE_TAG", "latest")
  app_deploy_on_docker_image_push = get_env("TF_VAR_APP_DEPLOY_ON_PUSH", "true")
}

remote_state {
  backend = "s3"
  config = {
    endpoint                    = get_env("TF_STATE_BUCKET_ENDPOINT", "https://fra1.digitaloceanspaces.com")
    bucket                      = get_env("TF_STATE_BUCKET_NAME", "application-tfstate")
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    region                      = get_env("TF_DO_REGION", "fra1")
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    disable_bucket_update       = true
  }
}
