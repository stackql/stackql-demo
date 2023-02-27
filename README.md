# StackQL Demo

This repository contains demos for StackQL using the command line `exec` and `shell` commands.  The followind additional demo repositories are available:  

- [StackQL Jupyter Notebook Demo](https://github.com/stackql/stackql-jupyter-demo)
- [`stackql-exec` GitHub Actions Demo](https://github.com/stackql/stackql-exec)
- [`stackql-assert` GitHub Actions Demo](https://github.com/stackql/stackql-assert)

**NOTE**: For these demos to work, you will need to:

1. Set required environment variables for provider authentication (see the [StackQL registry docs](https://registry.stackql.io/) for information sepcific to the provider you are using)
2. Place `google` service account json credentials in the `.gitignore`d location `creds/google-key.json`.
2. Edit references to provider objects to refer to objects you own, eg: the `google` project in `jsonnet` configuration blocks or files.

Demos are broken down by providers in the `providers` directory, for example `providers/aws` contains demos for the `aws` provider.  There are also multi cloud/cross provider demos in the `providers/multi-cloud` directory.  Subdirectories for Infrastructure as Code (IaC) demos and queries (including CSPM queriers) are included under each provider demo dir, for instance `providers/google/iac` and `providers/google/queries`.  

Before getting started, you can familairize yourself with the StackQL, including the object model and working with providers by looking at the following topics.

- [Exploring a provider](docs/discovery.md).
- [SQL Usage](docs/sql_usage.md).
- [Output Types - including `json`, `csv`, `table`](docs/outputs.md).
- [Creating Infrastructure Templates](docs/infra_templates.md).
- [Performing Lifecycle Operations](docs/lifecycle_ops.md).
- [Syncronous and Asnycronous Operations](docs/sync_async.md).