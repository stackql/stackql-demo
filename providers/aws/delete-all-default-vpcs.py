from pystackql import StackQL
stackql = StackQL()
stackql.executeStmt("REGISTRY PULL aws")

def ensure_one_or_zero(resource_list, resource_name, region):
    if len(resource_list) > 1:
        raise RuntimeError(f"ah snap! multiple default {resource_name} resources found in {region}")
    elif len(resource_list) == 0:
        print(f"/* no default {resource_name} found in {region} */\n")
        return False
    return True

regions = [
    'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2',
    'eu-central-1', 'eu-central-2', 'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1', 'eu-south-1',
    'ap-east-1', 'ap-south-1', 'ap-south-2', 'ap-northeast-1', 'ap-northeast-2', 'ap-northeast-3',
    'ap-southeast-1', 'ap-southeast-2', 'ap-southeast-3', 'ap-southeast-4', 'af-south-1',
    'ca-central-1',  'me-south-1', 'me-central-1', 'sa-east-1'
]

for region in regions:
    vpc_ids = stackql.execute(
        f"""
        SELECT
        vpc_id
        FROM aws.ec2.vpcs
        WHERE region = '{region}'
        AND cidr_block = '172.31.0.0/16'
        AND JSON_ARRAY_LENGTH(tags) = 0
        """
    )
    if not ensure_one_or_zero(vpc_ids, 'VPC', region): continue 
    vpc_id = vpc_ids[0]['vpc_id']
    
    # check if vpc is in use
    network_interfaces = stackql.execute(
        f"""
        SELECT
        id
        FROM aws.ec2.network_interfaces
        WHERE region = '{region}'
        AND vpc_id = '{vpc_id}'
        """
    )
    if len(network_interfaces) > 0:
        print(f"/* skipping deletion of default VPC ({vpc_id}) in {region} because it is in use */\n")
        continue
        
    print(f"/* deleting resources for default VPC ({vpc_id}) in {region} */\n")

    # get route table
    route_table_ids = stackql.execute(
        f"""
        SELECT
        route_table_id
        FROM aws.ec2.route_tables
        WHERE region = '{region}'
        AND vpc_id = '{vpc_id}'
        """
    )
    ensure_one_or_zero(route_table_ids, 'route table', region)
    route_table_id = route_table_ids[0]['route_table_id']

    # get inet gateway id
    inet_gateway_ids = stackql.execute(
        f"""
        SELECT gateway_id 
        FROM aws.ec2.routes 
        WHERE data__Identifier = '{route_table_id}|0.0.0.0/0' 
        AND region = '{region}'
        """
    )
    ensure_one_or_zero(inet_gateway_ids, 'internet gateway', region)
    inet_gateway_id = inet_gateway_ids[0]['gateway_id']

    # delete routes
    print(f"/* deleting default VPC routes in route table ({route_table_id}) in {region} */")
    print(f"""
DELETE FROM aws.ec2.routes
WHERE data__Identifier = '{route_table_id}|0.0.0.0/0'
AND region = '{region}';
    """)

    # detatch inet gateway
    print(f"/* detaching default VPC internet gateway ({inet_gateway_id}) in {region} */")
    print(f"""
DELETE FROM aws.ec2.vpc_gateway_attachments
WHERE data__Identifier = 'IGW|{vpc_id}'
AND region = '{region}';
    """)

    # delete inet gateway
    print(f"/* deleting default VPC internet gateway ({inet_gateway_id}) in {region} */")
    print(f"""
DELETE FROM aws.ec2.internet_gateways
WHERE data__Identifier = '{inet_gateway_id}'
AND region = '{region}';
    """)

    # delete nacl
    nacl_ids = stackql.execute(
        f"""
        SELECT
        id
        FROM aws.ec2.network_acls
        WHERE vpc_id = '{vpc_id}'
        AND region = '{region}'
        """
    )
    ensure_one_or_zero(nacl_ids, 'network acl', region)
    nacl_id = nacl_ids[0]['id']
    print(f"/* deleting default VPC NACL ({nacl_id}) in {region} */")
    print(f"""
DELETE FROM aws.ec2.network_acls
WHERE data__Identifier = '{nacl_id}'
AND region = '{region}';
    """)

    # delete subnets
    subnet_ids = stackql.execute(
        f"""
        SELECT
        subnet_id
        FROM aws.ec2.subnets
        WHERE vpc_id = '{vpc_id}'
        AND region = '{region}'
        """
    )
    for subnet_id in subnet_ids:
        print(f"/* deleting default VPC subnet ({subnet_id['subnet_id']}) in {region} */")
        print(f"""
DELETE FROM aws.ec2.subnets
WHERE data__Identifier = '{subnet_id['subnet_id']}'
AND region = '{region}';
        """)

    # delete vpc
    print(f"/* deleting default VPC ({vpc_id}) in {region} */")
    print(f"""
DELETE FROM aws.ec2.vpcs
WHERE data__Identifier = '{vpc_id}'
AND region = '{region}';
    """)