# Task

* Create account in DigitalOcean (you can get free credits via link https://try.digitalocean.com/cloud/)
* Fork test-application repo on your own GitHub account.
* Create Docker image for application.
* Create a CircleCI pipeline that does the following:
* On each commit to the master branch CircleCI builds a docker container and pushes to Docker Hub/DigitalOcean Registry
* Deploys to DigitalOcean App Platform

# Result
* The repository contains definitions for the CircleCI pipelines and a Terragrunt project defining the DigitalOcean infrastructure.
* For initial setup, refer to the Infrastructure section in the root folder's README.md.

## Notes
Best practices skipped due to time constraints:
* The Terragrunt project should be moved to a separate repository; for this task, it is left in the .terragrunt directory.
* The code and image should be scanned using a security scanner such as SonarQube or Snyk.

Additionally, the Terragrunt project can be run in CircleCI to avoid manual infrastructure setup.