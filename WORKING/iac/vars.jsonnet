// variables
local name = 'stackql-demo';
local project = 'stackql-demo';
local region = 'australia-southeast1';
local zone = 'australia-southeast1-a';
local images = import './iac/images.json';
local machineTypes = import './iac/machineTypes.json';
local jsonData = import './iac/vars.json';
local diskSizeGb = '10';

// functions
local instanceData(ix, machineType) =
    {
        name: "%s-%s" % [name, ix],
        zone: zone,
        project: project,
        machineType: machineTypes[machineType],
        deletionProtection: false,
        networkInterfaces: [{"subnetwork": "projects/%s/regions/%s/subnetworks/default" % [project,region,],}],
        disks: [{autoDelete: true, boot: true, initializeParams: {diskSizeGb: diskSizeGb, sourceImage: images["ubuntu-2004-lts"],}, mode: 'READ_WRITE', type: 'PERSISTENT'}],
        labels: [{'provisioner': 'stackql'}, {'owner': 'javen@stackql.io'}],
    };

{
 instances: [
    instanceData("005", "e2-micro"),
    instanceData("006", "e2-micro"),
    instanceData("007", "e2-micro"),
    instanceData("008", "e2-small"),
    instanceData("009", "e2-small"),
    instanceData("010", "e2-small"),
    instanceData("011", "e2-medium"),
    instanceData("012", "e2-medium"),        
 ],
 instancesSync: [
    instanceData("013", "g1-small"),
    instanceData("014", "g1-small"),
 ],
 instancesAsync: jsonData.instances,
}

