# Output types

StackQL supports `json`, `csv`, `table` and `text` output types.  `table` (the default output type) is appropriate for the interactive shell but may not be practical for CI routines, scripting, or data exports.  In such cases, `json` or `csv` output types are more appropriate.  

The output type can be changed using the `--output` flag.  For example, to change the output type to `json`, use the following command:

```bash
# example json output
./stackql exec --output json --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"
```

To output to a file, use the `-f` or `--outfile` flags.  For example, to output to a file called `instances.json`, use the following command:

```bash
# output json to a file
./stackql exec --output json -f instances.json --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"
```

`csv` output can be used with a header (default) or without a header using the `-H` flag.  The default delimiter is `,` but this can be changed using the `--delimiter` or `-d` flags.  For example, to output to a file called `instances.csv` without a header and using a `|` delimiter, use the following command:  

```bash
# output to a csv file delimited by a pipe
./stackql exec --output csv -f instances.csv -H -d="|" --auth="${AUTH}" "SELECT name, status FROM google.compute.instances WHERE project = 'stackql-demo' AND zone = 'australia-southeast1-a'"
```