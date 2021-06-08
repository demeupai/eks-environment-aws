
data "aws_availability_zones" "available" {}

module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                         = "${var.application}-${var.environment}-vpc"
  cidr                         = var.cidr_block_vpc
  azs                          = slice(data.aws_availability_zones.available.names, 0, var.azs_count)
  private_subnets              = [for i in range(var.azs_count) : cidrsubnet(var.cidr_block_vpc, 10, i)]
  public_subnets               = [for i in range(var.azs_count) : cidrsubnet(var.cidr_block_vpc, 10, i + 4)]
  database_subnets             = [for i in range(var.azs_count) : cidrsubnet(var.cidr_block_vpc, 10, i + 8)]
  create_database_subnet_group = false
  enable_nat_gateway           = true
  single_nat_gateway           = true
  enable_dns_hostnames         = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "Environment"                                 = var.environment
    "App"                                         = var.application
    "Name"                                        = "${var.application}-${var.environment}-network-shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
    "Environment"                                 = var.environment
    "App"                                         = var.application
    "Name"                                        = "${var.application}-${var.environment}-subnet-public"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "Environment"                                 = var.environment
    "App"                                         = var.application
    "Name"                                        = "${var.application}-${var.environment}-subnet-private"
  }
  database_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "Environment"                                 = var.environment
    "App"                                         = var.application
    "Name"                                        = "${var.application}-${var.environment}-database-private"
  }
}
