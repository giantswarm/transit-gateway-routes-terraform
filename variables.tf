variable "cluster_id" {
  description = "id of the cluster"
  type = string
}

variable "tgw_id" {
  description = "id of the tgw"
  type = string
}

variable "cidrs" {
  description = "cidrs to forward"
  type    = list(string)
  default = []
}