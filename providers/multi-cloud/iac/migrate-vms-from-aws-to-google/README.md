# Demo: Migrate VMs from AWS to Google Cloud

This demo shows how to migrate VMs from AWS to Google Cloud using StackQL, the same operation could be done in reverse (Google to AWS) or between any other cloud providers with analagous services.  

## Setup

Variables/parameters for this demo are stored in [vars.jsonnet](data/vars.jsonnet).  Modify this file as necessary for another environment.  This demo requires authentication to the `google` and `aws` providers, using a roles with the appropriate permissions in both providers.  

## Usage

To run this demo, execute the following command:

```bash
./stackql exec -i iql/migrate-from-aws-to-google.iql --auth="${AUTH}"
```

The output could be piped to a file or you could use the `-f` flag to write the output to a file.