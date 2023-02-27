$keyfilepath = "C:\tmp\infraql-demo.json"

Write-Output "--"
Write-Output "-- KUBERNETES THE HARD WAY INFRAQL DEMO"
Write-Output "--"
Write-Output ""
Write-Output "Creating Compute Resources (Dry Run)..."
infraql.exe exec -i ..\iql\compute-resources.iql --iqldata ..\data\vars.jsonnet --keyfilepath $keyfilepath --dryrun --outfile compute-resources-TEMPLATED.iql --output text --hideheaders

Write-Output "Creating Compute Resources ..."
infraql.exe exec -i ..\iql\compute-resources.iql --iqldata ..\data\vars.jsonnet --keyfilepath $keyfilepath

Write-Output "Bootstrapping Kubernetes Controllers (Dry Run)..."
$address = (gcloud compute addresses describe kubernetes-the-hard-way --region australia-southeast1 --project infraql-demo --format 'value(address)') 
Set-Content -Path address.tmp -Value $address -NoNewline
infraql.exe exec -i ..\iql\bootstrapping-kubernetes-controllers.iql --keyfilepath $keyfilepath --dryrun --outfile bootstrapping-kubernetes-controllers-TEMPLATED.iql --output text --hideheaders

Write-Output "Bootstrapping Kubernetes Controllers ..."
infraql.exe exec -i ..\iql\bootstrapping-kubernetes-controllers.iql --keyfilepath $keyfilepath

Write-Output "Creating Pod Network Routes (Dry Run)..."
infraql.exe exec -i ..\iql\pod-network-routes.iql --iqldata ..\data\vars.jsonnet --keyfilepath $keyfilepath --dryrun --outfile pod-network-routes-TEMPLATED.iql --output text --hideheaders

Write-Output "Creating Pod Network Routes (Dry Run)..."
infraql.exe exec -i ..\iql\pod-network-routes.iql --iqldata ..\data\vars.jsonnet --keyfilepath $keyfilepath

Write-Output "Selecting instances ..."
$query = "`"select id, name, machineType from compute.instances where project = 'infraql-demo' and zone = 'australia-southeast1-a';`""
$flags = "--keyfilepath ${keyfilepath} --output json"
$cmd = "infraql.exe exec"

$select = $cmd, $query, $flags -join " "
(Invoke-Expression $select | ConvertFrom-Json) | Out-GridView -Title 'InfraQL Query Results'