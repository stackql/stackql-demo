# StackQL Demo

**NOTE**: For these demos to work, you will need to:

1. Place `google` service account json credentials in the `.gitignore`d location `creds/google-key.json`.
2. Edit references to provider objects, eg: the `google` project in [iac/vars.jsonnet](/iac/vars.jsonnet), to refer to objects you own.

This repository contains demos of different StackQL functions, including:

- [Exploring a provider](/README.md#exploring-a-provider).
- [Infrastructure as Code](/README.md#infrastructure-as-code).
- [Querying a Provider](/README.md#querying-a-provider).
- [Jupyter Notebook Demo](/README.md#jupyter-notebook-demo).
- [Lifecycle Operations](/README.md#lifecycle-operations).

## Exploring a Provider
Run meta commands from `exploring-a-provider.iql` in the StackQL shell to explore a provider, including `SHOW` and `DESCRIBE` commands.

## Infrastructure as Code
Run commands from `infrastructure-as-code.sh` to demonstrate infrastructure as code functions including:

- Creating infrastructure templates using `SHOW INSERT INTO`
- Sourcing variables from `json` and `jsonnet` files
- Provisioning resources asynchronously and synchronously
- De-provisioning resources

## Querying a Provider
Run commands from `querying-a-provider.iql` to demonstrate querying a provider.

## Jupyter Notebook Demo
See the [Jupyter Notebook Demo](jupyter-demo/README.md) to perform analysis and visualization using StackQL.

## Lifecycle Operations
Run commands from `lifecycle-operations.iql` to demonstrate lifecycle operations, such as starting or stopping a VM instance.