keyfilepath="/tmp/infraql-demo.json"

echo "###"
echo "### KUBERNETES THE HARD WAY INFRAQL DEMO"
echo "###"
echo ""
echo "Creating Compute Resources (Dry Run)..."
infraql exec -i ../iql/compute-resources.iql \
--iqldata ../data/vars.jsonnet \
--keyfilepath $keyfilepath \
--dryrun \
--outfile compute-resources-TEMPLATED.iql \
--output text \
--hideheaders

echo "Creating Compute Resources ..."
infraql exec -i ../iql/compute-resources.iql \
--iqldata ../data/vars.jsonnet \
--keyfilepath $keyfilepath

echo "Bootstrapping Kubernetes Controllers (Dry Run)..."
address=`gcloud compute addresses describe kubernetes-the-hard-way --region australia-southeast1 --project infraql-demo --format 'value(address)'` 
echo $address > address.tmp
infraql exec -i ../iql/bootstrapping-kubernetes-controllers.iql \
--keyfilepath $keyfilepath \
--dryrun \
--outfile bootstrapping-kubernetes-controllers-TEMPLATED.iql \
--output text \
--hideheaders

echo "Bootstrapping Kubernetes Controllers ..."
infraql exec -i ../iql/bootstrapping-kubernetes-controllers.iql \
--keyfilepath $keyfilepath

echo "Creating Pod Network Routes (Dry Run)..."
infraql exec -i ../iql/pod-network-routes.iql \
--iqldata ../data/vars.jsonnet \
--keyfilepath $keyfilepath \
--dryrun \
--outfile pod-network-routes-TEMPLATED.iql \
--output text \
--hideheaders

echo "Creating Pod Network Routes (Dry Run)..."
infraql exec -i ../iql/pod-network-routes.iql \
--iqldata ../data/vars.jsonnet \
--keyfilepath $keyfilepath

echo "Selecting instances ..."
query="select id, name, machineType from compute.instances where project = 'infraql-demo' and zone = 'australia-southeast1-a'"
infraql exec -i $query \
--keyfilepath $keyfilepath \
--output table