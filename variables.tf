variable "region" {
  default = "us-east-1"
}
variable "domain" {
  default = "XXXXXXXXXX.com.br"
}

variable "sub_domain" {
  default = "XXXXXXXXXX"
}
####################################
#-------------Parametros comuns
####################################
variable "cluster-name" {
  default     = "XXXXXXXXXX-eks"
}
variable "name" {
  default     = "XXXXXXXXXX"
}
variable "environment" {
  type        = string
  default     = "development"
}
variable "application" {
  type        = string
  default     = "XXXXXXXXXX"
}
####################################
#-------------VPC
####################################
variable "cidr_block_vpc" {
  type        = string
  default     = "20.0.0.0/16"
}

variable "azs_count" {
  type    = number
  default = 3
}
####################################
#--------Security Group
####################################
variable "cidr_bastion" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "pg_port" {
  type        = string
  default     = "5432"
}
variable "bastion-egress" {
  type        = list(string)
  default     = ["all-all"]
}

variable "bastion-ingress" {
  type        = string
  default     = "all-all"
}

variable "ssh-port" {
  type        = string
  default     = "22"
}
####################################
#--------EC2 Bastion
####################################
variable "bastion-type" {
  type        = string
  default     = "t3a.small"
}

variable "bastion-keys" {
  type        = string
  default     = "jobii-devops"
}

variable "bastion-ebs-size" {
  type        = string
  default     = "200"
}
variable "bastion-instance-number" {
  type        = string
  default     = "1"
}
variable "bastion-name" {
  type        = string
  default     = "bastion"
}

variable "bastion-ami" {
  type        = string
  default     = "ami-096fda3c22c1c990a"
}

####################################
#--------RDS - PostgreSQL
####################################
variable "pg-instance-class-api" {
  type        = string
  description = "XXXXXXXXXX"
  default     = "db.t3.medium"
}
variable "pg-allocated-store-api" {
  type        = string
  description = "XXXXXXXXXX"
  default     = "100"
}
variable "pg-max-allocated-storage-api" {
  type        = string
  description = "XXXXXXXXXX"
  default     = "700"
}
variable "pg-store-encrypted" {
  type        = string
  default     = "false"
}
variable "pg-database-api" {
  type        = string
  default     = "xxxxx"
}

variable "apply_immediately" {
  type        = string
  default     = "true"
}

variable "pg-user-api" {
  type        = string
  default     = "xxxxx"
}

variable "pg-maintenance-window" {
  type        = string
  default     = "Sat:00:00-Sat:03:00"
}
variable "pg-backup-window" {
  type        = string
  default     = "03:00-06:00"
}
variable "pg-backup-retention" {
  type        = string
  default     = "30"
}
variable "pg-delete-protection" {
  type        = string
  default     = "true"
}
variable "pg-insights_retention_period" {
  type        = string
  default     = "7"
}
####################################
#--------Kubernetes
####################################
variable "eks-version" {
  type        = string
  default     = "1.19"
}

variable "eks-worker-group-name-one" {
  type        = string
  default     = "worker-group-large"
}

variable "eks-worker-group-name-two" {
  type        = string
  default     = "worker-group-medium"
}

variable "eks-instance-type-group-one" {
  type        = string
  default     = "t3a.large"
}

variable "eks-instance-type-group-two" {
  type        = string
  default     = "t3a.medium"
}


variable "eks-worker-group-one-capacity" {
  type        = string
  default     = "1"
}

variable "eks-worker-group-two-capacity" {
  type        = string
  default     = "1"
}
