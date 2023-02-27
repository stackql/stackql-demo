$keyfilepath = "C:\tmp\infraql-demo.json"

Write-Output "--"
Write-Output "-- KUBERNETES THE HARD WAY INFRAQL DEMO - CLEANUP"
Write-Output "--"
Write-Output ""
Write-Output "Cleanup (Dry Run)..."
infraql.exe exec -i ..\iql\cleanup.iql --iqldata ..\data\vars.jsonnet --keyfilepath $keyfilepath --dryrun --outfile cleanup-TEMPLATED.iql --output text --hideheaders
Write-Output "Cleanup (for real) ..."
infraql.exe exec -i ..\iql\cleanup.iql --iqldata ..\data\vars.jsonnet --keyfilepath $keyfilepath
