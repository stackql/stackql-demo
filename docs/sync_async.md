# Syncronous and Asynchronous Operations

StackQL mutation operations sucn as [`INSERT`](https://stackql.io/docs/language-spec/insert), `UPDATE`, [`DELETE`](https://stackql.io/docs/language-spec/delete) and [`EXEC`](https://stackql.io/docs/language-spec/exec are asyncronous and non-blocking by default (if this is implemented by the provider).  This behavior can be changed by using the `/*+ AWAIT */` query hint.  For example, to perform a synchronous `INSERT` operation, run the following:

```sql
INSERT /*+ AWAIT */ INTO google.compute.disks(
  project,
  zone,
  data__name,
  data__sizeGb
)
SELECT
  'stackql-demo',
  'australia-southeast1-a',
  'test-disk-1',
  '512'
;
```
Progress information will be returned as the operation progresses.  For example:

```bash
compute#operation: insert in progress, 10 seconds elapsed                                                                         
compute#operation: insert in progress, 20 seconds elapsed
compute#operation: insert in progress, 30 seconds elapsed
compute#operation: insert complete
```
