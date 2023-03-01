# Demo: Migrate VMs from AWS to Google Cloud

This demo shows how to migrate VMs from AWS to Google Cloud using StackQL, the same operation could be done in reverse (Google to AWS) or between any other cloud providers with analagous services.  

## Setup

Variables/parameters for this demo are stored in [vars.jsonnet](data/vars.jsonnet).  Modify this file as necessary for another environment.  This demo requires authentication to the `google` and `aws` providers, using a roles with the appropriate permissions in both providers.  

Run the following to set up the necessary `auth` struct, and pull the providers required for this demo:  

```bash
bindir=../../..
$bindir/stackql exec "registry pull google"
$bindir/stackql exec "registry pull aws"
AUTH='{ "google": { "type": "service_account",  "credentialsfilepath": "../../../creds/stackql-demo.json" }, "aws": { "type": "aws_signing_v4", "credentialsenvvar": "AWS_SECRET_ACCESS_KEY", "keyIDenvvar": "AWS_ACCESS_KEY_ID" }}'
```

## Usage

To perform a dryrun of the migration, execute the following command:

```bash
$bindir/stackql exec -i iql/migrate-from-aws-to-google.iql --iqldata data/vars.jsonnet --output text -H --dryrun
```

To run this demo, execute the following command:

```bash
$bindir/stackql exec -i iql/migrate-from-aws-to-google.iql --iqldata data/vars.jsonnet --auth="${AUTH}"
```

The output could be piped to a file or you could use the `-f` flag to write the output to a file.


$bindir/stackql shell --auth="${AUTH}"
