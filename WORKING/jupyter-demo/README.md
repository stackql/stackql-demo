# stackql-demo-jupyter

## Instructions

1. Build the image:
```bash
cp ../stackql ./bin/stackql; docker build --no-cache -t stackql-demo-jupyter .
```
2. Run the image:
```shell
docker run -dp 8888:8888 --env-file ./apikeys.env stackql-demo-jupyter start-notebook.sh --NotebookApp.token=''
```
3. Stop your running container when finished:
```shell
docker stop $(docker ps -l -q --filter status=running --filter ancestor=stackql-demo-jupyter)
```
