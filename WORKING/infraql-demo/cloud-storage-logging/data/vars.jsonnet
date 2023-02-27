// variables


local name = 'kubernetes-the-hard-way';
local project = 'infraql-demo';
local region = 'australia-southeast1';
local zone = 'australia-southeast1-a';
local self_link_base = 'https://compute.googleapis.com/compute/v1/projects/' + project + '/';
local self_link_global = self_link_base + 'global/';
local self_link_regional = self_link_base + 'regions/' + region + '/';
local self_link_zonal = self_link_base + 'zones/' + zone + '/';
local sourceImage = 'https://compute.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts';
local machineType = self_link_zonal + 'machineTypes/f1-micro';
local diskSizeGb = '10';

{
  // global config
  global: {
    project: project,
    region: region,
    zone: zone
  },
  // base instance config
  instance: {
    project: project,
    zone: zone,
    canIpForward: true,
    deletionProtection: false,
    disks: [{autoDelete: true, boot: true, initializeParams: {diskSizeGb: diskSizeGb, sourceImage: sourceImage}, mode: 'READ_WRITE', type: 'PERSISTENT'}],
    machineType: machineType,
    scheduling: {automaticRestart: true},
    serviceAccounts: [{email: 'default', scopes: ['https://www.googleapis.com/auth/compute', 'https://www.googleapis.com/auth/devstorage.read_only', 'https://www.googleapis.com/auth/logging.write', 'https://www.googleapis.com/auth/monitoring', 'https://www.googleapis.com/auth/service.management.readonly', 'https://www.googleapis.com/auth/servicecontrol']}]
  }, 
  // controller instance config
  controller_instance: self.instance
     {
       metadata: {},
       tags: {items: [name, 'controller']}
     }
  ,
  // worker instance config
  worker_instance: self.instance
     {
       tags: {items: [name, 'worker']}
     }
  ,  
  // network
  network: {
    autoCreateSubnetworks: false,
    name: name,
    routingConfig: {routingMode: 'REGIONAL'}
  },
  // subnet
  subnetwork: {
    ipCidrRange: '10.240.0.0/24',
    name: 'kubernetes',
    network: self_link_global + 'networks/' + name,
    privateIpGoogleAccess: false
  },
  // public IP addr
  address: {
    name: name
  },
  // routes
  routes: [
    {
      project: project,
      destRange: '10.200.0.0/24', 
      name: 'kubernetes-route-10-200-0-0-24', 
      network: self_link_global + 'networks/' + name,
      nextHopIp: '10.240.0.20', 
      priority: 1000
    },
    {
      project: project,
      destRange: '10.200.1.0/24', 
      name: 'kubernetes-route-10-200-1-0-24', 
      network: self_link_global + 'networks/' + name,
      nextHopIp: '10.240.0.21', 
      priority: 1000
    },
    {
      project: project,
      destRange: '10.200.2.0/24', 
      name: 'kubernetes-route-10-200-2-0-24', 
      network: self_link_global + 'networks/' + name,
      nextHopIp: '10.240.0.22', 
      priority: 1000
    }    
  ]
  ,
  // firewall rules
  firewalls: [
    {
      project: project,
      allowed: [{IPProtocol: 'tcp'}, {IPProtocol: 'udp'}, {IPProtocol: 'icmp'}], 
      direction: 'INGRESS', 
      name: name + '-allow-internal-fw', 
      network: self_link_global + 'networks/' + name,
      sourceRanges: ['10.240.0.0/24', '10.200.0.0/16']
    },
    {
      project: project,
      allowed: [{IPProtocol: 'tcp', ports: ['22']}, {IPProtocol: 'tcp', ports: ['6443']},{IPProtocol: 'icmp'}],
      direction: 'INGRESS', 
      name: name + '-allow-external-fw', 
      network: self_link_global + 'networks/' + name,
      sourceRanges: ['0.0.0.0/0']
    }
  ],
  instances: [
     self.controller_instance + 
      { 
        name: 'controller-0',
        networkInterfaces: [{accessConfigs: [{name: 'external-nat', type: 'ONE_TO_ONE_NAT'}], networkIP: '10.240.0.10', subnetwork: self_link_regional + 'subnetworks/kubernetes'}]
      }
    ,
     self.controller_instance +
      {
        name: 'controller-1',
        networkInterfaces: [{accessConfigs: [{name: 'external-nat', type: 'ONE_TO_ONE_NAT'}], networkIP: '10.240.0.11', subnetwork: self_link_regional + 'subnetworks/kubernetes'}]
      }
    ,
     self.controller_instance +
      {
        name: 'controller-2',
        networkInterfaces: [{accessConfigs: [{name: 'external-nat', type: 'ONE_TO_ONE_NAT'}], networkIP: '10.240.0.12', subnetwork: self_link_regional + 'subnetworks/kubernetes'}]
      }
    ,
     self.worker_instance +      
      {
        name: 'worker-0',
        metadata: {items: [{key: 'pod-cidr', value: '10.200.0.0/24'}]},
        networkInterfaces: [{accessConfigs: [{name: 'external-nat', type: 'ONE_TO_ONE_NAT'}], networkIP: '10.240.0.20', subnetwork: self_link_regional + 'subnetworks/kubernetes'}]
      }
    ,
     self.worker_instance +
      {
        name: 'worker-1',
        metadata: {items: [{key: 'pod-cidr', value: '10.200.1.0/24'}]},
        networkInterfaces: [{accessConfigs: [{name: 'external-nat', type: 'ONE_TO_ONE_NAT'}], networkIP: '10.240.0.21', subnetwork: self_link_regional + 'subnetworks/kubernetes'}]
      }
    ,
     self.worker_instance +
      {
        name: 'worker-2',
        metadata: {items: [{key: 'pod-cidr', value: '10.200.2.0/24'}]},
        networkInterfaces: [{accessConfigs: [{name: 'external-nat', type: 'ONE_TO_ONE_NAT'}], networkIP: '10.240.0.22', subnetwork: self_link_regional + 'subnetworks/kubernetes'}]      }
  ],
  // health checks
  httpHealthCheck : {
        "checkIntervalSec": 5, 
        "description": "Kubernetes Health Check", 
        "healthyThreshold": 2, 
        "host": "kubernetes.default.svc.cluster.local", 
        "name": "kubernetes", 
        "port": 80, 
        "requestPath": "/healthz", 
        "timeoutSec": 5, 
        "unhealthyThreshold": 2
    }
}