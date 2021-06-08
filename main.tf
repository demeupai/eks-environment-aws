locals {
  cluster_name = "${var.name}-${var.environment}"
  name         = var.name
}

provider "aws" {
  region = var.region
}

#terraform state rm module.eks.kubernetes_config_map.aws_auth