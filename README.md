# Test application

## Requirements

NodeJS 16+

## Installing dependencies

To install dependencies run `npm install`

## Running application

By default application is listening on 3000 port, but it can be changed to different via environment variable `LISTEN_PORT`

To run application, execute `npm run start` or `node src/app.js`

## Infrastructure
This project includes a Docker registry on DigitalOcean (DO) Container Registry, an application on DO App Platform, and a CI/CD pipeline using CircleCI.

### Initial Setup
1. Create Container Registry and DO App. 
* Follow instructions in `.terraform/README.md`.

2. Setup CircleCI Project.
* Connect the repository to a CircleCI project. Follow the instructions at CircleCI Create Project. https://circleci.com/docs/create-project/

3. Create CirceCi project. 
* Follow the instruction https://circleci.com/docs/create-project/
* Crete a CirceCi context: 
```
* Context name: `localozedev-test-application-context`
* Add next env variables to the context:

REGISTRY_URL=<your registry_url from terrafrom output> # required
DOCKER_USERNAME=<your DO email> # required
DOCKER_PASSWORD=<your DO token> # required
IMAGE_NAME=<Docker image name> # optional
APP_LIVE_URL=<your app_live_url from terrafrom output> # optional

```

You are now set up to use the CI/CD system. After each push to the master branch, your app will be built, tested, and delivered automatically.