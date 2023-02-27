keyfilepath="/tmp/infraql-demo.json"

echo "###"
echo "### KUBERNETES THE HARD WAY INFRAQL DEMO"
echo "###"
echo ""
echo "Cleanup (Dry Run)..."
infraql exec -i ../iql/cleanup.iql \
--iqldata ../data/vars.jsonnet \
--keyfilepath $keyfilepath \
--dryrun \
--outfile cleanup-TEMPLATED.iql \
--output text \
--hideheaders
echo "Cleanup (for real) ..."
infraql exec -i ../iql/cleanup.iql \
--iqldata ../data/vars.jsonnet \
--keyfilepath $keyfilepath
