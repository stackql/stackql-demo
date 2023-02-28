# Lifecycle Operations

Lifecycle operations are operations that change the state of a resource during its lifecycle (typically performed via SysOps and usually not in the scope of Infrastructre-as-Code routines).  Examples of lifecycle operations include:

- Starting or Stopping a VM instance
- Creating a snapshot or backup of a VM instance
- Disabling a user
- Attaching or detaching volumes or NICs
- Moving a resource

As StackQL provides a route to every operation within a provider's API, it is possible to perform lifecycle operations using StackQL.  Lifecycle operations are performed using the [__`EXEC`__](https://stackql.io/docs/language-spec/exec) command within StackQL.  The following example demonstrates how to stop and start a VM instance in GCP:  

```sql
-- stop a running instance
EXEC google.compute.instances.stop 
@instance='stackql-demo-001',
@project='stackql-demo',
@zone='australia-southeast1-a';

-- check the status of the instance
SELECT name, status 
FROM google.compute.instances 
WHERE project = 'stackql-demo' 
AND zone = 'australia-southeast1-a' 
AND name = 'stackql-demo-001';

-- stop a running instance
EXEC google.compute.instances.start 
@instance='stackql-demo-001',
@project='stackql-demo',
@zone='australia-southeast1-a';

-- check the status of the instance (again)
SELECT name, status 
FROM google.compute.instances 
WHERE project = 'stackql-demo' 
AND zone = 'australia-southeast1-a' 
AND name = 'stackql-demo-001';
```

By default, these operations are asynchronous and will return immediately; this behavior can be changed as discussed in [Syncronous and Asynchronous Operations](sync_async.md).
