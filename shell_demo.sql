select 
name,
JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size,
SPLIT_PART(id, '/', 5) as resource_group,
location 
from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468';

select vm_size, count(*) as num_vms FROM
(
SELECT
name,
JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size,
SPLIT_PART(id, '/', 5) as resource_group,
location 
from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468'
) t GROUP BY vm_size;

SELECT name, status 
FROM google.compute.instances 
WHERE project = 'stackql-demo' 
AND zone = 'australia-southeast1-a';

EXEC google.compute.instances.stop 
@instance='stackql-demo-004',
@project='stackql-demo',
@zone='australia-southeast1-a';

EXEC google.compute.instances.start 
@instance='stackql-demo-004',
@project='stackql-demo',
@zone='australia-southeast1-a';