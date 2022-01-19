# What is this terraform module
This module will create route table entries to forward traffic from a cluster to a transit gateway.

Developed and tested with Terraform v1.1.2

# How to use the module
Create a main.tf file with the following contents:
```
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region  = "eu-west-1"
}

module "qq77k-routes" {
  source = "../giantswarm-routes"

  cluster_id = "qq77k"
  tgw_id = "tgw-06b8782d6cc0568ac"
  routes = [
      "10.1.13.0/24",
      "10.1.12.0/24",
  ]
}
```

Commands

```
> terraform init
> terraform plan
> terraform apply
```

## Connect two clusters via TGW
```
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region  = "eu-west-1"
}

module "qq77k-routes" {
  source = "../giantswarm-routes"

  #Cluster ID
  cluster_id = "qq77k"
  #TGW Id
  tgw_id = "tgw-06b8782d6cc0568ac"
  #VPC CIDRS of qq77k except the CNI CIDR
  routes = [
      "10.1.13.0/24",
      "10.1.12.0/24",
  ]
}

module "tb79w-routes" {
  source = "../giantswarm-routes"

  #Cluster ID
  cluster_id = "tb79w"
  #TGW Id
  tgw_id = "tgw-06b8782d6cc0568ac"
  #VPC CIDRS of qq77k except the CNI CIDR
  routes = [
      "10.1.11.0/24",
      "10.1.18.0/24",
  ]
}
```