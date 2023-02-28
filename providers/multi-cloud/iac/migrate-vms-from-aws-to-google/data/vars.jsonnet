{
   project: 'stackql-demo-2',
   zone: 'australia-southeast1-a',
   awsRegion: 'us-east-1',
   machineTypes: {
    f1micro: 'https://www.googleapis.com/compute/v1/projects/stackql-demo-2/zones/australia-southeast1-a/machineTypes/f1-micro',
   },
   disks: [{autoDelete: true, boot: true, initializeParams: {diskSizeGb: '10', sourceImage: 'https://compute.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts'}, mode: 'READ_WRITE', type: 'PERSISTENT'}],
}
