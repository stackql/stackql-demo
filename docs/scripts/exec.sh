#
# Output types
#

# example json output
./stackql exec --output json --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"

# output json to a file
./stackql exec --output json -f instances.json --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"

# output to a csv file
./stackql exec --output csv -f instances.csv --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"

# output to a csv file delimited by a pipe
./stackql exec --output csv -f instances_pipe_delimited.csv -H -d="|" --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"

# example azure queries
./stackql exec \
--output json \
"select vm_size, count(*) as num_vms FROM ( SELECT name, JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size, SPLIT_PART(id, '/', 5) as resource_group, location from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468' ) t GROUP BY vm_size"

./stackql exec \
--output json -f vm_sizes.json \
"select vm_size, count(*) as num_vms FROM ( SELECT name, JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size, SPLIT_PART(id, '/', 5) as resource_group, location from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468' ) t GROUP BY vm_size"

./stackql exec \
--output csv -f virtual_machines.csv -H -d="|" \
"select name, JSON_EXTRACT(properties, '$.hardwareProfile.vmSize') as vm_size, SPLIT_PART(id, '/', 5) as resource_group, location from azure.compute.virtual_machines_all where subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468'"


#
# infra templates
#

# use the SHOW INSERT command to show ALL properties
./stackql --output=text -H exec "SHOW INSERT INTO google.compute.instances"

# use the /*+ REQUIRED */ hint to show only REQUIRED properties
./stackql exec --output=text -H -f virtual_machines.iql "SHOW INSERT /*+ REQUIRED */ INTO azure.compute.virtual_machines"

# populate the variables 
#  resourceGroupName = 'stackql-demo'
#  subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468'
#  vmName = 'stackql-demo-vm'

# dry run the template using
./stackql exec --dryrun --output=text -H -i virtual_machines.iql -f virtual_machines_RENDERED.iql

# deploy the template using
./stackql exec --auth="${AUTH}" -i virtual_machines.iql -f output.log
