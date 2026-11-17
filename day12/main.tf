locals {
  formatted_project_name = lower(replace(var.project_name, " ", "-"))
  new_tag                = merge(var.default_tags, var.enviroment_tags)
  formatted_bucket_name = replace(replace(
    substr(
      lower(var.bucket_name),
    0, 63),
    " ", ""),
  "!", "")
 
  port_list=split("," , var.allowed_ports)
  sg_rules=[ for port in local.port_list : 
    {
      name="port-${port}"
      port=port
      
    }
  ]

  instance_size=lookup(var.instance_sizes,var.enviroment,"t2.micro")

  all_locations=concat(var.user_locations,var.default_locations)

  unique_locations=toset(local.all_locations)

  positive_cost=[for cost in var.monthly_costs: abs(cost)]
  max_cost=max(local.positive_cost...)
  min_cost=min(local.positive_cost...)
  total_cost=sum(local.positive_cost)
  avg_cost=local.total_cost/(length(local.positive_cost))
  current_timestamp=timestamp()

  format1=formatdate("yyyyMMdd",local.current_timestamp)

  format2=formatdate("YYYY-MM-DD",local.current_timestamp)

  config_file_exists=fileexists("./config.json")
  config_data=local.config_file_exists? jsondecode(file("./config.json")) : {}
}

resource "aws_s3_bucket" "firsts3" {
  bucket = local.formatted_bucket_name
  tags   = local.new_tag
}
