variable "cluster_id" {
  description = "id of the cluster"
  type = string
}

variable "tgw_id" {
  description = "id of the tgw"
  type = string
}

variable "routes" {
  description = "routes to forward"
  type    = list(string)
  default = []
}