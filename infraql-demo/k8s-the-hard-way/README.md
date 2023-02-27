# InfraQL Demo - Kubernetes the Hard Way

This demonstration uses [InfraQL](https://docs.infraql.io/) and [Jsonnet](https://jsonnet.org/) for the Google Cloud Platform operations from the [Kubernetes the Hard Way project](https://github.com/kelseyhightower/kubernetes-the-hard-way).

## Prerequisites
- a Google Cloud Platform project
- Service account key with permissions to create and delete resources
- InfraQL installed 

## Running on Windows

- Update `.\data\vars.jsonnet` to set variables for your environment (`project`, `region`, `zone`, `diskSizeGb`, `machineType`)
- Update the `$keyfilepath` variable in the `.\scripts\deploy.ps1` and `.\scripts\teardown.ps1` files to the path to your service account key file 
- Run `.\scripts\deploy.ps1` to deploy resources
- Run `.\scripts\teardown.ps1` to clean up resources deployed when you are finished

## Running on Mac/Linux

- Update `./data/vars.jsonnet` to set variables for your environment (`project`, `region`, `zone`, `diskSizeGb`, `machineType`)
- Update the `keyfilepath` variable in the `./scripts/deploy.sh` and `./scripts/teardown.sh` files to the path to your service account key file 
- Run `./scripts/deploy.sh` to deploy resources
- Run `./scripts/teardown.sh` to clean up resources deployed when you are finished