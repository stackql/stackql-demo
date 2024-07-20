distributions_list = stackql.execute("""
SELECT
id
FROM aws.cloudfront.distributions
WHERE region = 'us-east-1'
"""
)['id'].tolist()

distributions_details = stackql.execute(f"""
SELECT
  d.id,
  je.value as data
FROM
  aws_cloudfront_distribution d,
  json_each(json_extract(d.distribution_config, '$.Origins')) je
WHERE region = 'us-east-1'
AND data__Identifier IN ('{"','".join(distributions_list)}')
"""
)
