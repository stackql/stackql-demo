# StackQL Infrastructure Templates

StackQL can be used for Infrastructure-as-Code routines using [__`INSERT`__](https://stackql.io/docs/language-spec/insert), `UPDATE` and [__`DELETE`__](https://stackql.io/docs/language-spec/delete) operations.  StackQL creates infrastructure templates (`INSERT` templates) that can be used to provision new instances of cloud resources in a provider.  

StackQL supports __`json`__ and [__`jsonnet`__](https://jsonnet.org/) as configuration languages for supplying parameters and variables to IaC and query operations.  `INSERT` templates include a `jsonnet` block for parameterization; this can be used inline in the shell or supplied via an external file, for more information see: [__`Using Variables`__](https://stackql.io/docs/getting-started/variables).  

## Creating an `INSERT` template

To create an `INSERT` template, run the following command:

```
SHOW INSERT INTO google.compute.instances;
```

To see only the required parameters for provisioning a given resource, use the `/*+ REQUIRED */` query hint as shown here:

```
SHOW INSERT /*+ REQUIRED */ INTO google.compute.instances;
```

It is probably more practical to use the `exec` command to create an `INSERT` template (as opposed to `stackql shell`); this will create an output file that can be used, for example:

```
stackql exec --output=text -H -f instances.iql "SHOW INSERT INTO google.compute.instances"
```