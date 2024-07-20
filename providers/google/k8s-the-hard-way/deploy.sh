# keyfilepath="/tmp/stackql-demo.json"

echo "###"
echo "### KUBERNETES THE HARD WAY stackql DEMO"
echo "###"
echo ""
echo "Creating Compute Resources (Dry Run)..."
../../../stackql exec -i ./iql/compute-resources.iql \
--iqldata ./data/vars.jsonnet \
# --keyfilepath $keyfilepath \
--dry-run \
--outfile compute-resources-TEMPLATED.iql \
--output text \
--hideheaders

# echo "Creating Compute Resources ..."
# stackql exec -i ../iql/compute-resources.iql \
# --iqldata ../data/vars.jsonnet \
# --keyfilepath $keyfilepath

echo "Bootstrapping Kubernetes Controllers (Dry Run)..."
# address=`gcloud compute addresses describe kubernetes-the-hard-way --region australia-southeast1 --project stackql-demo --format 'value(address)'` 
# echo $address > address.tmp
../../../stackql exec -i ./iql/bootstrapping-kubernetes-controllers.iql \
# --keyfilepath $keyfilepath \
--iqldata ./data/vars.jsonnet \
--dry-run \
--outfile bootstrapping-kubernetes-controllers-TEMPLATED.iql \
--output text \
--hideheaders

# echo "Bootstrapping Kubernetes Controllers ..."
# stackql exec -i ../iql/bootstrapping-kubernetes-controllers.iql \
# --keyfilepath $keyfilepath

echo "Creating Pod Network Routes (Dry Run)..."
../../../stackql exec -i ./iql/pod-network-routes.iql \
--iqldata ./data/vars.jsonnet \
# --keyfilepath $keyfilepath \
--dry-run \
--outfile pod-network-routes-TEMPLATED.iql \
--output text \
--hideheaders

# echo "Creating Pod Network Routes (Dry Run)..."
# stackql exec -i ../iql/pod-network-routes.iql \
# --iqldata ../data/vars.jsonnet \
# --keyfilepath $keyfilepath

# echo "Selecting instances ..."
# query="select id, name, machineType from compute.instances where project = 'stackql-demo' and zone = 'australia-southeast1-a'"
# stackql exec -i $query \
# --keyfilepath $keyfilepath \
# --output table