#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Step 1: Run Terragrunt init, plan, and apply
echo "Running terragrunt init..."
terragrunt init --terragrunt-non-interactive || terragrunt init --terragrunt-non-interactive

echo "Running terragrunt plan..."
terragrunt plan --terragrunt-non-interactive

echo "Running terragrunt apply..."
terragrunt apply -var docker_image_name="" -auto-approve --terragrunt-non-interactive

# Step 2: Extract registry_url from Terragrunt output
echo "Extracting registry_url from terragrunt output..."
REGISTRY_URL=$(terragrunt output -raw registry_url)

# Check if REGISTRY_URL is empty
if [ -z "$REGISTRY_URL" ]; then
  echo "Error: REGISTRY_URL is empty. Exiting..."
  exit 1
fi
echo "Registry URL: $REGISTRY_URL"

# Step 3: Build Docker image
cd ../
echo "Building Docker image..."
DOCKER_IMAGE_NAME=${TF_VAR_DOCKER_IMAGE_NAME}
DOCKER_IMAGE_TAG="latest"
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

# Step 4: Push Docker image to the registry
echo "Pushing Docker image to the registry..."
docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ${REGISTRY_URL}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
docker push ${REGISTRY_URL}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}

# Step 6: Re-run Terragrunt plan and apply
cd .terragrunt
echo "Re-running terragrunt plan with the new Docker image..."
terragrunt plan --terragrunt-non-interactive

echo "Re-running terragrunt apply with the new Docker image..."
terragrunt apply -auto-approve --terragrunt-non-interactive

# Step 7: Extract and display the app_live_url from Terragrunt output
echo "Extracting app_live_url from terragrunt output..."
APP_LIVE_URL=$(terragrunt output -raw app_live_url)

# Check if APP_LIVE_URL is empty
if [ -z "$APP_LIVE_URL" ]; then
  echo "Error: APP_LIVE_URL is empty. Exiting..."
  exit 1
fi

# Display registry_url and app_live_url
echo "Registry URL: $REGISTRY_URL"
echo "Application Live URL: $APP_LIVE_URL"
