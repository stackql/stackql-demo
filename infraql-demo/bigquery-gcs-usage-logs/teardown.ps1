$keyfilepath = "C:\tmp\infraql-demo.json"

# dryrun
infraql.exe exec -i .\cleanup.iql --keyfilepath $keyfilepath --dryrun --outfile cleanup-TEMPLATED.iql --output text --hideheaders

# execute
infraql.exe exec -i .\cleanup.iql --keyfilepath $keyfilepath
