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

  validation {
    condition     = length(var.cidrs) >=1
    error_message = "You must set at least one CIDR to be added."
  }
}