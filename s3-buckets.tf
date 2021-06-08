module "log_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket                                = "${var.application}-${var.environment}-logs"
  acl                                   = "log-delivery-write"
  force_destroy                         = true
  tags = {
    "Environment" = var.environment
    "App"         = var.application
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket        = "${var.application}-${var.environment}"
  acl           = "private"
  force_destroy = true
  tags = {
    "Environment" = var.environment
    "App"         = var.application
  }
  versioning = {
    enabled = true
  }

   logging = {
     target_bucket = module.log_bucket.s3_bucket_id
     target_prefix = "log/"
   }

  block_public_acls       = true
  restrict_public_buckets = true
  block_public_policy     = true
  ignore_public_acls      = true
}

