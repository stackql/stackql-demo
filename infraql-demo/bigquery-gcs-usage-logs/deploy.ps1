$keyfilepath = "C:\tmp\infraql-demo.json"

# dryrun
infraql.exe exec -i .\bq.iql --keyfilepath $keyfilepath --dryrun --outfile bq-TEMPLATED.iql --output text --hideheaders

# execute
infraql.exe exec -i .\bq.iql --keyfilepath $keyfilepath