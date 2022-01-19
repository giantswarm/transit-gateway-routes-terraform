#Find VPC of the cluster we want to modify
data "aws_vpc" "cluster_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.cluster_id]
  }
}

#Search all the route tables of the cluster we want to modify
data "aws_route_tables" "route_tables" {
  vpc_id = data.aws_vpc.cluster_vpc.id

  filter {
    name   = "tag:giantswarm.io/cluster"
    values = [var.cluster_id]
  }
}

#Generate the structure combining all the route tables with all the CIDRs we want to add
locals {
  entries = flatten([
    for route_table in data.aws_route_tables.route_tables.ids : [
      for route in var.routes : {
        route_table = route_table
        route    = route
      }
    ]
  ])
}

#Create all the route table entries
resource "aws_route" "routes" {
  for_each = {
    for entry in local.entries : "${entry.route_table}-${entry.route}" => entry
  }

  route_table_id            = each.value.route_table
  destination_cidr_block    = each.value.route
  transit_gateway_id        = var.tgw_id
}