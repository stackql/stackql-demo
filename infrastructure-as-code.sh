# 
# GENERATING INFRASTRUCTURE TEMPLATES
# 

./stackql exec --output text -H "SHOW INSERT INTO google.storage.buckets"
./stackql exec --output text -H "SHOW INSERT /*+ REQUIRED */ INTO google.storage.buckets"

#
# PROVISIONING INFRASTRUCTURE
#

./stackql exec --dryrun --output text -H -f test.sql -i ./iac/deploy-instances-async.iql --iqldata ./iac/vars.json

AUTH='{ "google": { "credentialsfilepath": "creds/stackql-demo-d929cfea5089.json",  "type": "service_account" }, "okta": { "credentialsenvvar": "OKTA_SECRET_KEY", "type": "api_key" }, "github": { "credentialsenvvar": "GITHUB_CREDS",  "type": "basic" }, "netlify": { "credentialsenvvar": "NETLIFY_TOKEN",  "type": "api_key", "valuePrefix": "Bearer "}}'
./stackql exec -i ./iac/deploy-instances-async.iql --iqldata ./iac/vars.json --auth="${AUTH}" 
./stackql exec -i ./iac/deploy-instances-async.iql --iqldata ./iac/vars.jsonnet --auth="${AUTH}"
./stackql exec -i ./iac/deploy-instances-sync.iql --iqldata ./iac/vars.jsonnet --auth="${AUTH}"

#
# CLONING INFRASTRUCTURE
#

INSERT /*+ AWAIT */ INTO google.compute.instances 
(
zone,
project,
data__name,
data__machineType,
data__deletionProtection,
data__networkInterfaces,
data__disks,
data__labels
) 
SELECT
zone,
'stackql-demo-2',
name,
machineType,
deletionProtection,
'[{"subnetwork":"' || JSON_EXTRACT(networkInterfaces, '$[0].subnetwork') || '"}]',
'[{"boot": true,"initializeParams":{"diskSizeGb": "' || JSON_EXTRACT(disks, '$[0].initializeParams.diskSizeGb') || '","sourceImage": "' || JSON_EXTRACT(disks, '$[0].initializeParams.sourceImage') || '"}}]',
labels
FROM google.compute.instances
WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'
AND name LIKE 'stackql-demo-%';

'stackql-demo-2',


SELECT
i.zone, 
i.name,
i.machineType,
i.deletionProtection,
'[{"subnetwork":"' || JSON_EXTRACT(i.networkInterfaces, '$[0].subnetwork') || '"}]',
'[{"boot": true,"initializeParams":{"diskSizeGb": "' || JSON_EXTRACT(i.disks, '$[0].diskSizeGb') || '","sourceImage": "' || d.sourceImage || '"}}]',
i.labels
FROM google.compute.instances i
INNER JOIN google.compute.disks d 
ON i.name = d.name
WHERE i.project = 'stackql-demo' AND i.zone = 'australia-southeast1-a'
AND d.project = 'stackql-demo' AND d.zone = 'australia-southeast1-a'
AND i.name LIKE 'stackql-demo-%';




, 
from google.compute.instances i
inner join 
on i.name = d.name
where i.project = 'stackql-demo' AND i.zone = 'australia-southeast1-a'
and i.name LIKE 'stackql-demo-%'
and  d.project = 'stackql-demo' AND d.zone = 'australia-southeast1-a';


where i.project = 'stackql-demo-2' and i.zone = 'australia-southeast1-a'

select id, name, sourceImage from  google.compute.disks where project = 'stackql-demo' and zone = 'australia-southeast1-a';



SELECT
'[{"boot": true,"initializeParams":{"diskSizeGb": "' || JSON_EXTRACT(disks, '$[0].initializeParams.diskSizeGb') || '","sourceImage": "' || JSON_EXTRACT(disks, '$[0].initializeParams.sourceImage') || '"}}]'
disks

SELECT disks FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a' AND name LIKE 'stackql-demo-%' limit 1





#
# DEPROVISIONING INFRASTRUCTURE
#

./stackql exec -i ./iac/deprovision-instances.iql --iqldata ./iac/vars.jsonnet --auth="${AUTH}"


