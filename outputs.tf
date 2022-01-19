output "route_table_entries" {
  value = [
    for route in aws_route.routes: route.id
  ]
}