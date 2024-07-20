./stackql exec \
--output json \
"select vm_size, count(*) as num_vms FROM ( SELECT name, JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size, SPLIT_PART(id, '/', 5) as resource_group, location from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468' ) t GROUP BY vm_size"

./stackql exec \
--output json -f vm_sizes.json \
"select vm_size, count(*) as num_vms FROM ( SELECT name, JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size, SPLIT_PART(id, '/', 5) as resource_group, location from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468' ) t GROUP BY vm_size"

./stackql exec \
--output csv -f virtual_machines.csv -H -d="|" \
"select name, JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size, SPLIT_PART(id, '/', 5) as resource_group, location from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468'"