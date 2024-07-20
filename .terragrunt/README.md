# Localozedev-test-application infrastructure

The Terragrunt project is configured to store `terraform.tfstate` in the DigitalOcean Space Object Storage

## Initial setup

### Set Environment Variables
```bash
export TF_VAR_DO_TOKEN=<DigitalOcean API token> # Obtain from https://cloud.digitalocean.com/account/api/tokens
export AWS_ACCESS_KEY_ID=<DigitalOcean ACCESS_KEY_ID> # Obtain from https://cloud.digitalocean.com/account/api/spaces
export AWS_SECRET_ACCESS_KEY=<DigitalOcean SECRET_ACCESS_KEY> # Obtain from https://cloud.digitalocean.com/account/api/spaces
```

### Automated Setup
Run the following script from the `.terragrunt` directory:
```
bash init_infrastructure.sh
```

The infrastructure is ready! Please follow instructions in the root README.MD

### Manual setup

1. Initialize Terragrunt:
The first init could be insuccess due to Terragrunt and DigitalOcean communication specific
```bash
terragrunt init || terragrunt init
```

2. Create the Docker registry:
```bash
terragrunt plan
terragrunt apply
```

3. Push image to the registry. 
You can do it via Circle CI. Follow CircleCI setup instructions in the root README.md

4. Create the Application. 
```bash
export TF_VAR_DOCKER_IMAGE_NAME=<your Docker image name> # required
export TF_VAR_DOCKER_IMAGE_TAG=<your Docker image tag> # optional (default is "latest")

terragrunt plan
terragrunt apply
```
