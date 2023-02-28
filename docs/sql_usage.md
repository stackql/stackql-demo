# StackQL SQL Usage

<details open="open">
<summary>Contents</summary>
<ol>
<li><a href="#basic-select-operations">Basic <code>SELECT</code> operations</a></li>
<li><a href="#built-in-functions">Built in functions</a></li>
<li><a href="#string-json-functions">String/JSON functions</a></li>
<li><a href="#date-functions">Date functions</a></li>
<li><a href="#summary-aggregation-operations">Summary/Aggregation operations</a></li>
<li><a href="#union-and-join-operations"><code>UNION</code> and <code>JOIN</code> operations</a></li>
<!-- <li><a href="#windowing-functions">Windowing functions</a></li> -->
</ol>
</details>
<br />

StackQL implements a SQL language variant for querying cloud resources.  The language is ANSI SQL with extensions. Complete documentation for the language can be found in the [Language Specification](https://stackql.io/docs).  A summary of salient features is provided below.  

## Basic `SELECT` operations

Simple `SELECT` queries can be run against a resource (provided the necessary authentication was provided).  Column projection, as well as `SELECT *` are supported.  For example, to list all instances in a given AWS region showing the `instanceId` and `instanceType` fields, run the following:

```sql
SELECT instanceId, instanceType 
FROM 
aws.ec2.instances 
WHERE region = 'us-east-1';
```

To return the `id`, `name` and `machineType` of all instances in a given GCP `project` and `zone`, run the following:

```sql
SELECT id, 
name, 
machineType 
FROM 
google.compute.instances 
WHERE project = 'stackql-demo' 
AND zone = 'australia-southeast1-a';
```

> StackQL keywords such as `SELECT`, `FROM` etc, are not case sensitive - they are often capitalized by convention.  However, object names and field names are case-sensitive.

## Built-in functions

Most common scalar functions you would expect in a SQL language are supported with StackQL, including string, date, math, regular expression and json scalar functions.  More information on functions, their usage, and examples see the [StackQL docs](https://stackql.io/docs) in the __Functions__ section of the __Language Specification__.  

### String/JSON functions

In many API responses, values are nested in JSON objects.  StackQL provides a [__`JSON_EXTRACT`__](https://stackql.io/docs/language-spec/functions/json/json_extract) function to extract values from JSON objects.  In addition, some resource fields are returned as urls or self-links.  StackQL provides a [__`SPLIT_PART`__](https://stackql.io/docs/language-spec/functions/string/split_part) function to extract parts of a string and just provide the meaningful value.  This query demonstrates the use of both the `JSON_EXTRACT` and `SPLIT_PART` functions:  

> The `id` field contains the string `/subscriptions/631d1c6d-2a65-43e7-93c2-688bfe4e1468/resourceGroups/stackql-ops-cicd-dev-01/providers/Microsoft.Compute/virtualMachines/test` and the `properties` field contains an object with a `hardwareProfile` field which in turn contains a `vmSize` field.  The `SPLIT_PART` function is used to extract the subscription id and the resource group name from the `id` field.  The `JSON_EXTRACT` function is used to extract the `vmSize` value from the `properties` field.

```sql
SELECT name,  
 split_part(id, '/', 3) as subscription,
 split_part(id, '/', 5) as resource_group,
 json_extract(properties, '$.hardwareProfile.vmSize') as vm_size
FROM azure.compute.virtual_machines 
 WHERE resourceGroupName = 'stackql-ops-cicd-dev-01' 
 AND subscriptionId = '631d1c6d-2a65-43e7-93c2-688bfe4e1468';
```

### Date functions

StackQL implements several date/time functions including [__`DATE`__](https://stackql.io/docs/language-spec/functions/datetime/date), [__`DATETIME`__](https://stackql.io/docs/language-spec/functions/datetime/datetime-fn), [__`JULIANDAY`__](https://stackql.io/docs/language-spec/functions/datetime/julianday), [__`STRFIME`__](https://stackql.io/docs/language-spec/functions/datetime/strftime) and [__`TIME`__](https://stackql.io/docs/language-spec/functions/datetime/time).  The following query demonstrates the use of the `JULIANDAY` along with the [`ROUND`](https://stackql.io/docs/language-spec/functions/math/round) mathematical function to calculate the number of days since a bucket was created in GCP:

```sql
SELECT name, timeCreated,
round(julianday('now')-julianday(timeCreated)) as days_since
FROM google.storage.buckets WHERE project = 'stackql';
```

## Summary/Aggregation operations

StackQL supports the standard SQL `GROUP BY` and `HAVING` clauses for summary and aggregation operations.  Standard summary functions such as [__`COUNT`__](https://stackql.io/docs/language-spec/functions/aggregate/count), [__`SUM`__](https://stackql.io/docs/language-spec/functions/aggregate/sum), [__`AVG`__](https://stackql.io/docs/language-spec/functions/aggregate/avg), and extrema function such as [__`MIN`__](https://stackql.io/docs/language-spec/functions/aggregate/min) and [__`MAX`__](https://stackql.io/docs/language-spec/functions/aggregate/max) are supported.  

The following query demonstrates the use of the `GROUP BY` clause to return the number of instance types for instances in an AWS region:

```sql
SELECT instanceType, COUNT(*) as num_instances 
FROM aws.ec2.instances 
WHERE region = 'us-east-1' 
GROUP BY instanceType;
```

The following example demonstrates the use of the `HAVING` clause to return the number of instances in a given GCP project and zone grouped by instance type and status, where the number of instances is greater than 2:  

```sql
SELECT SUBSTR(machineType,103) as machineType, status, COUNT(*) as num_instances
FROM google.compute.instances 
WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'
GROUP BY machineType, status
HAVING COUNT(*) > 2;
```

## `UNION` and `JOIN` operations

Standard relational algebra operations such as `UNION` and `JOIN` are supported.  The following query demonstrates the use of the `UNION` operation to return the number of instances across multiple AWS regions:  

> 🚀 `UNION` and `JOIN` operations are fully supported across providers!

```sql
SELECT 'us-east-1' as region, COUNT(*) as num_instances
FROM aws.ec2.instances
WHERE region = 'us-east-1'
UNION
SELECT 'us-west-2' as region, COUNT(*) as num_instances
FROM aws.ec2.instances
WHERE region = 'us-west-1';
```

`JOIN` operations, including complex `JOIN` operations spanning multiple resources (tables) are supported.  The following query demonstrates a `JOIN`:  

```sql
select n.id, n.name, n.IPv4Range, s.name as subnetwork_name
from google.compute.networks n 
inner join google.compute.subnetworks s on n.name =  split_part(s.network, '/', 10) 
where n.project = 'stackql-demo'
and s.project = 'stackql-demo'
and s.region = 'australia-southeast1';
```