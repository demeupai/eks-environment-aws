resource "random_password" "rds_password" {
  length  = 16
  special = false
}

module "rds-api" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.0.0"

  identifier = "${var.name}-${var.environment}-database"

  engine               = "postgres"
  engine_version       = "13.1"
  family               = "postgres13"
  major_engine_version = "13"
  instance_class       = var.pg-instance-class-api
  apply_immediately    = var.apply_immediately

  allocated_storage     = var.pg-allocated-store-api
  max_allocated_storage = var.pg-max-allocated-storage-api
  storage_encrypted     = var.pg-store-encrypted

  name     = var.pg-database-api
  username = var.pg-user-api
  password = random_password.rds_password.result

  port                                  = var.pg_port
  multi_az                              = true
  subnet_ids                            = module.vpc.database_subnets
  vpc_security_group_ids                = [module.sg-db.security_group_id]
  maintenance_window                    = var.pg-maintenance-window
  backup_window                         = var.pg-backup-window
  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]
  backup_retention_period               = var.pg-backup-retention
  skip_final_snapshot                   = false
  deletion_protection                   = var.pg-delete-protection
  performance_insights_enabled          = true
  performance_insights_retention_period = var.pg-insights_retention_period
  parameters = [
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
}