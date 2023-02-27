// variables
local organization_id = 'organizations/630166304837';
local root_node = organization_id; // update if you want the root to be another folder
local salt = 'infraql';
local prefix = 'asolns';
local billing_account_id = '630166304837';
local admin_group_email = 'jeffreyaven@avensolutions.com';
local environments = [{name: 'prod'}, {name: 'nonprod'}];
local generate_project_id(name, salt) = name + '-' + std.substr(std.md5(name + salt), 1, 5);

{
	organization_id: organization_id,
	root_node: root_node,
	billing_account_id: billing_account_id,
	environments: environments,
	prefix: prefix,
	root_projects: [
		{
			displayName: 'terraform',
			projectId: generate_project_id('terraform', salt),
			apis: [
				'container.googleapis.com',
				'stackdriver.googleapis.com',			
			],
		},
		{
			displayName: 'audit',
			projectId: generate_project_id('audit', salt),
			apis: [
				'bigquery.googleapis.com',
				'container.googleapis.com',
				'stackdriver.googleapis.com',
			],
		},
		{
			displayName: 'sharedsvc',
			projectId: generate_project_id('sharedsvc', salt),
			apis: [
				'container.googleapis.com',
				'stackdriver.googleapis.com',			
			],
		},
	],
}