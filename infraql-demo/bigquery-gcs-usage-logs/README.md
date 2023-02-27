# InfraQL Demo - Analyzing GCS usage logs in Big Query

This demonstration uses [InfraQL](https://docs.infraql.io/) and [Jsonnet](https://jsonnet.org/) to prepare datasets and tables, load and query GCS usage logs using Big Query see the article: [Enable Logging for Google Cloud Storage Buckets and Analyzing Logs in Big Query (Part II)](https://docs.infraql.io/blog/analyze-gcs-usage-logs-in-bigquery).

## Prerequisites
- a Google Cloud Platform project
- Service account key with permissions to create and delete resources
- InfraQL installed 

## Configure

- Update `bq.iql` to set variables for your environment

## Perform a dryrun

- Run the following command to perform a dryrun:
for Mac or Linux run:
```bash
infraql exec -i ./bq.iql --dryrun --outfile bq-TEMPLATED.iql --output text --hideheaders
```
for Windows run:
```powershell
infraql.exe exec -i .\bq.iql --dryrun --outfile bq-TEMPLATED.iql --output text --hideheaders
```
- Inspect the `bq-TEMPLATED.iql` file

## Deploy
for Mac or Linux run:
```bash
infraql exec -i ./bq.iql --keyfilepath '/path/to/your/keyfile'
```
for Windows run:
```powershell
infraql.exe exec -i .\bq.iql --keyfilepath 'C:\path\to\your\keyfile'
```
## Cleanup (optional)
If you want to delete the resources you created in the previous step, run the following:  
for Mac or Linux run:
```bash
infraql exec -i ./cleanup.iql --keyfilepath '/path/to/your/keyfile'
```
for Windows run:
```powershell
infraql.exe exec -i .\cleanup.iql --keyfilepath 'C:\path\to\your\keyfile'
```
