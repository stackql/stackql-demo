local gcp_project = 'stackql-demo-2';
local gcp_region = 'australia-southeast1';
local gcp_zone = 'australia-southeast1-a';
local aws_region = 'us-east-1';
local images = import './data/images.json';
local diskSizeGb = '10';

local get_scoped_url(project, scopeName, scope, type, name) = "https://www.googleapis.com/compute/v1/projects/%s/%s/%s/%s/%s" % [project, scopeName, scope, type, name];

{
   project: gcp_project,
   zone: gcp_zone,
   awsRegion: aws_region,
   machineTypes: {
    e2micro: get_scoped_url(gcp_project, "zones", gcp_zone, "machineTypes", "e2-micro"),
   },
   disks: [
      {
         autoDelete: true, 
         boot: true, 
         initializeParams: {
            diskSizeGb: diskSizeGb, 
            sourceImage: images["ubuntu-2004-lts"]
         }, 
         mode: 'READ_WRITE', 
         type: 'PERSISTENT'
      }
   ],
   networkInterfaces: [
      {
         subnetwork: get_scoped_url(gcp_project, "regions", gcp_region, "subnetworks", "default"), 
      }
   ],
}
