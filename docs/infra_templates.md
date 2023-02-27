# StackQL Infrastructure Templates

<details open="open">
<summary>Contents</summary>
<ol>
<li><a href="#creating-an-insert-template">Creating an `INSERT` template</a></li>
<li><a href="#using-a-template">Using a template</a></li>
<li><a href="#dry-running-a-template">Dry running a template</a></li>
</ol>
</details>
<br />
StackQL can be used for Infrastructure-as-Code routines using [__`INSERT`__](https://stackql.io/docs/language-spec/insert), `UPDATE` and [__`DELETE`__](https://stackql.io/docs/language-spec/delete) operations.  StackQL creates infrastructure templates (`INSERT` templates) that can be used to provision new instances of cloud resources in a provider.  

StackQL supports __`json`__ and [__`jsonnet`__](https://jsonnet.org/) as configuration languages for supplying parameters and variables to IaC and query operations.  `INSERT` templates include a `jsonnet` block for parameterization; this can be used inline in the shell or supplied via an external file; for more information, see: [__`Using Variables`__](https://stackql.io/docs/getting-started/variables).  

## Creating an `INSERT` template

To create an `INSERT` template, run the following command:

```
SHOW INSERT INTO azure.compute.virtual_machines;
```

To see only the required parameters for provisioning a given resource, use the `/*+ REQUIRED */` query hint as shown here:

```
SHOW INSERT /*+ REQUIRED */ INTO azure.compute.virtual_machines;
```

It is probably more practical to use the `exec` command to create an `INSERT` template (as opposed to `stackql shell`); this will create an output file that can be used, for example:

```
./stackql exec --output=text -H -f virtual_machines.iql "SHOW INSERT /*+ REQUIRED */ INTO azure.compute.virtual_machines"
```

The infrastructure template generated looks like this:  

```
<<<jsonnet
{
   resourceGroupName: << resourceGroupName >>,
   subscriptionId: << subscriptionId >>,
   vmName: << vmName >>
}
>>>
INSERT INTO azure.compute.virtual_machines(
  resourceGroupName,
  subscriptionId,
  vmName
)
SELECT
  '{{ .values.resourceGroupName }}',
  '{{ .values.subscriptionId }}',
  '{{ .values.vmName }}'
;
```

You would then supply the `resourceGroupName`, `subscriptionId` and `vmName` parameters in the `jsonnet` block.

## Using a template

To use a template, provide the parameters in the `jsonnet` block and deploy using the `exec` command (or by using the [__`stackql-exec` GitHub Action__](https://github.com/marketplace/actions/stackql-studios-stackql-exec)):

```
./stackql exec --auth="${AUTH}" -i virtual_machines.iql -f output.log
```

## Dry running a template

If you want to see the rendered query, you can use the `--dryrun` flag as shown here:

```
./stackql exec --dryrun --output=text -H -i virtual_machines.iql -f virtual_machines_RENDERED.iql
```

The output looks like this:

```sql
INSERT INTO azure.compute.virtual_machines(
  resourceGroupName,
  subscriptionId,
  vmName
)
SELECT
  'stackql-demo',
  '631d1c6d-2a65-43e7-93c2-688bfe4e1468',
  'stackql-demo-vm'
;
```