> ⚡ **Calling All Cloud/Data/Security Enthusiasts, Hacktoberfest 2024 is here!** ⚡  
> Interested in contributing StackQL (SQL) queries for **Cloud Security Posture Management (CSPM)**, **FinOps**, **Cloud Inventory Analysis**, or **Infrastructure-as-Code (IaC)**?  
> Check out the issues and get started with your first pull request!  
> Let’s build something amazing together this Hacktoberfest!  
> 💡 **Explore our repositories:** [StackQL](https://github.com/stackql/stackql), [StackQL Deploy](https://stackql-deploy.io/docs/), find provider documentation in the [StackQL Provider Registry Docs](https://registry.stackql.io/)

Build out example queries for [`aws`](https://aws.stackql.io/providers/aws/), [`gcp`](https://google.stackql.io/providers/google/), [`azure`](https://azure.stackql.io/providers/azure/), [`digitalocean`](https://digitalocean.stackql.io/providers/digitalocean/), [`linode`](https://linode.stackql.io/providers/linode/), [`okta`](https://okta.stackql.io/providers/okta/) and more, including multicloud queries!

---

# StackQL Demo

This repository contains demos for StackQL using the command line `exec` and `shell` commands.  The following additional demo repositories are available:  

- [StackQL Jupyter Notebook Demo](https://github.com/stackql/stackql-jupyter-demo)
- [`stackql-exec` GitHub Actions Demo](https://github.com/stackql/stackql-exec)
- [`stackql-assert` GitHub Actions Demo](https://github.com/stackql/stackql-assert)

**NOTE**: For these demos to work, you will need to:

1. Set required environment variables for provider authentication (see the [StackQL registry docs](https://registry.stackql.io/) for information sepcific to the provider you are using)
2. (for GCP examples) Place `google` service account json credentials in the `.gitignore` location `creds/stackql-demo.json`.
3. (for GCP examples) Edit references to provider objects to refer to objects you own, eg: the `google` project in `jsonnet` configuration blocks or files.
4. Download the latest `stackql` release for your platform, for Linux you can use the following commands: `curl -L https://bit.ly/stackql-zip -O && unzip stackql-zip`

Demos are broken down by providers in the `providers` directory, for example `providers/aws` contains demos for the `aws` provider.  There are also multi cloud/cross provider demos in the `providers/multi-cloud` directory.  Subdirectories for Infrastructure as Code (IaC) demos and queries (including CSPM queriers) are included under each provider demo dir, for instance `providers/google/iac` and `providers/google/queries`.  

Before getting started, you can familairize yourself with the StackQL, including the object model and working with providers by looking at the following topics.

- [Exploring a provider](docs/discovery.md).
- [SQL Usage](docs/sql_usage.md).
- [Output Types - including `json`, `csv`, `table`](docs/outputs.md).
- [Creating Infrastructure Templates](docs/infra_templates.md).
- [Performing Lifecycle Operations](docs/lifecycle_ops.md).
- [Syncronous and Asnycronous Operations](docs/sync_async.md).